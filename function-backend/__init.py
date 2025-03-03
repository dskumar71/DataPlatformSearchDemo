# function-backend/__init__.py

import azure.functions as func
import logging
import json
from .search_handler import handle_search_request

def main(req: func.HttpRequest) -> func.HttpResponse:
    logging.info("Search function triggered.")

    try:
        request_data = req.get_json()
        search_by = request_data.get("search_by")
        search_value = request_data.get("search_value")

        if not search_by or not search_value:
            return func.HttpResponse(
                "Missing required fields (search_by, search_value)",
                status_code=400
            )

        results = handle_search_request(search_by, search_value)

        return func.HttpResponse(
            json.dumps(results),
            mimetype="application/json",
            status_code=200
        )

    except Exception as e:
        logging.error(f"Error processing request: {str(e)}")
        return func.HttpResponse(f"Internal Server Error: {str(e)}", status_code=500)
