# DataPlatformSearchDemo

## Overview
This project provides a full-stack solution to search across:
- Structured Data in Fabric SQL
- Unstructured Data (PDFs, Documents) in ADLS Gen2 (OneLake)

## Architecture
```text
+--------------------+
| React Frontend (Static Web App) |
+--------------------+
        |
        v
+--------------------+
| Azure API Management |
+--------------------+
        |
        v
+--------------------+
| Azure Function (Python) |
| (Queries both Fabric SQL & Cognitive Search) |
+--------------------+
        |
        +--> Fabric SQL Query (structured)
        +--> Cognitive Search Query (unstructured files)

