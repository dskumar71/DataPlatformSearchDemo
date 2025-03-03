// infra/storage.bicep

param location string = resourceGroup().location
param storageAccountName string = 'dataplatformsearchdemostorage'

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
    name: storageAccountName
    location: location
    sku: {
        name: 'Standard_LRS'
    }
    kind: 'StorageV2'
    properties: {
        accessTier: 'Hot'
        isHnsEnabled: true  // Hierarchical Namespace enabled (ADLS Gen2)
    }
}

resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-09-01' = {
    parent: storageAccount::blobServices::default
    name: 'files'
    properties: {
        publicAccess: 'None'
    }
}
