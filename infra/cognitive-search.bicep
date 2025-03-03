// infra/cognitive-search.bicep

param location string = resourceGroup().location
param searchServiceName string = 'dataplatformsearchdemosearch'

resource searchService 'Microsoft.Search/searchServices@2023-03-01' = {
    name: searchServiceName
    location: location
    sku: {
        name: 'basic'
    }
    properties: {
        hostingMode: 'default'
    }
}
