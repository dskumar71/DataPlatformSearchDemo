// infra/static-web-app.bicep

param location string = 'centralus'
param staticWebAppName string = 'dataplatformsearchdemoui'

resource staticWebApp 'Microsoft.Web/staticSites@2022-03-01' = {
    name: staticWebAppName
    location: location
    sku: {
        name: 'Free'
    }
    properties: {
        repositoryUrl: 'https://github.com/dskumar71/DataPlatformSearchDemo'
        branch: 'main'
        buildProperties: {
            appLocation: 'react-frontend'
            apiLocation: ''
            outputLocation: 'build'
        }
    }
}
