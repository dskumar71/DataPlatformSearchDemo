# function-backend/search_handler.py

import os
import pyodbc
from azure.core.credentials import AzureKeyCredential
from azure.search.documents import SearchClient

# Environment variables (you can set these in Azure Function App settings)
FABRIC_SQL_CONNECTION_STRING = os.getenv("FABRIC_SQL_CONNECTION_STRING")
COGNITIVE_SEARCH_ENDPOINT = os.getenv("COGNITIVE_SEARCH_ENDPOINT")
COGNITIVE_SEARCH_KEY = os.getenv("COGNITIVE_SEARCH_KEY")
COGNITIVE_SEARCH_INDEX = os.getenv("COGNITIVE_SEARCH_INDEX")

def handle_search_request(search_by, search_value):
    structured_data = query_fabric_sql(search_by, search_value)
    unstructured_data = query_cognitive_search(search_by, search_value)

    return {
        "FabricDatabase": structured_data,
        "BlobStorage": unstructured_data
    }

def query_fabric_sql(search_by, search_value):
    column = "Name" if search_by.lower() == "name" else "ID"
    query = f"SELECT ID, Name, Type, CreatedDate FROM SearchableEntities WHERE {column} = ?"

    connection = pyodbc.connect(FABRIC_SQL_CONNECTION_STRING)
    cursor = connection.cursor()
    cursor.execute(query, (search_value,))

    results = [
        dict(zip([column[0] for column in cursor.description], row))
        for row in cursor.fetchall()
    ]

    connection.close()
    return results

def query_cognitive_search(search_by, search_value):
    search_field = "Name" if search_by.lower() == "name" else "ID"

    client = SearchClient(
        endpoint=COGNITIVE_SEARCH_ENDPOINT,
        index_name=COGNITIVE_SEARCH_INDEX,
        credential=AzureKeyCredential(COGNITIVE_SEARCH_KEY)
    )

    filter_expression = f"{search_field} eq '{search_value}'"
    results = client.search(search_text="*", filter=filter_expression)

    formatted_results = []
    for result in results:
        formatted_results.append({
            "FileName": result["FileName"],
            "Name": result.get("Name", ""),
            "ID": result.get("ID", ""),
            "Tags": result.get("Tags", []),
            "DownloadUrl": result.get("DownloadUrl", "")  # Include this if you generate a SAS URL
        })

    return formatted_results
