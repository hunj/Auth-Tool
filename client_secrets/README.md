client_secrets.json
===

Format for basic 3-legged OAuth entries:
---
```
{
  "api_name":{
    "temporary_credential_uri": "oauth/request_token",
    "authorization_uri": "oauth/authorize",
    "token_credential_uri": "oauth/access_token",
    "client_credential_key": "key",
    "client_credential_secret": "secret",
    "callback": "callback",
    "verifier": "verifier",
    "params:"{
      "sample_param": "sample"
    }
  }
```
Parameters:
---
- **api_name**: lowercase name of the API/company
- **temporary_credential_uri**: full URL of the request token endpoint
- **authorization_uri**: URL to redirect the user to so they can authenticate with the service
- **token_credential_uri**: full URL of the access token endpoint
- **client_credential_key**: Client key (ID) provided by the service's API dashboard
- **client_credential_secret**: Client secret provided by the service's API dashboard
- **callback**: Securable callback URL (**TODO:** update once we figure out the endpoint)
- **verifier**: Name of the verifier key that the Auth server passes back after the user successfully authenticates with them
- **params**: (Optional) Hash of extra parameter values that the API requests
