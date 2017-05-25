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
    "verifier": "verifier"
  }
```
Parameters:
---
- api_name: lowercase name of the API/company
- temporary_credential_uri: full URL of the request token endpoint
- authorization_uri: URL to redirect the user to so they can authenticate with the service
- token_credential_uri: 
