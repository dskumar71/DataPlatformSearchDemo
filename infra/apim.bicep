// infra/apim.bicep

param location string = resourceGroup().location
param apimName string = 'dataplatformsearchdemoapim'
param functionAppHostName string = 'dataplatformsearchdemofunction.azurewebsites.net'

resource apim 'Microsoft.ApiManagement/service@2022-08-01' = {
    name: apimName
    location: location
    sku: {
        name: 'Consumption'
    }
    properties: {
        publisherEmail: 'your-email@domain.com'
        publisherName: 'DataPlatform Team'
    }
}

resource api 'Microsoft.ApiManagement/service/apis@2022-08-01' = {
    parent: apim
    name: 'search-api'
    properties: {
        displayName: 'DataPlatform Search API'
        path: 'search'
        protocols: ['https']
        serviceUrl: 'https://${functionAppHostName}/api'
        apiType: 'http'
    }
}
