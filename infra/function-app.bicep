// infra/function-app.bicep

param location string = resourceGroup().location
param functionAppName string = 'dataplatformsearchdemofunction'

resource functionApp 'Microsoft.Web/sites@2022-09-01' = {
    name: functionAppName
    location: location
    properties: {
        httpsOnly: true
        siteConfig: {
            appSettings: [
                { name: 'FUNCTIONS_WORKER_RUNTIME', value: 'python' }
                { name: 'FABRIC_SQL_CONNECTION_STRING', value: '<replace-with-connection-string>' }
                { name: 'COGNITIVE_SEARCH_ENDPOINT', value: '<replace-with-search-endpoint>' }
                { name: 'COGNITIVE_SEARCH_KEY', value: '<replace-with-search-key>' }
                { name: 'COGNITIVE_SEARCH_INDEX', value: 'files-index' }
            ]
        }
    }
}
