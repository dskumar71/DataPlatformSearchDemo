// infra/fabric-sql.bicep

param location string = resourceGroup().location
param sqlServerName string = 'dataplatformsearchdemosqlserver'
param sqlDbName string = 'dataplatformsearchdemodb'
param adminUser string = 'sqladmin'
param adminPassword string = 'YourStrong@Password123'

resource sqlServer 'Microsoft.Sql/servers@2021-11-01' = {
    name: sqlServerName
    location: location
    properties: {
        administratorLogin: adminUser
        administratorLoginPassword: adminPassword
    }
}

resource sqlDatabase 'Microsoft.Sql/servers/databases@2021-11-01' = {
    parent: sqlServer
    name: sqlDbName
    properties: {
        collation: 'SQL_Latin1_General_CP1_CI_AS'
    }
}
