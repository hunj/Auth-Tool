AuthTool
===
General purpose OAuth tool for API integrations. Utilizes [signet](https://github.com/google/signet).

Usage
---
```
require 'auth_tool'

client = AuthTool::get_client {secrets hash}
AuthTool::get_redirect_url client

# receive data from front-end

AuthTool::receive(client,response)
AuthTool::call(client, "get" "https://api.example.com/endpoint", params)
```
GET
---
All query parameters just go into the params array for AuthTool::call. Any headers must go into the params hash as a :headers hash.

Example:
```
params = {"username" => "user", "created" => "date", :headers => {"headerKey" => headerHash}}
```
POST
---
Headers go into the params hash as a :headers hash. Body goes into params as a :body hash. Anything else can just go into params.
Example:
```
params = {:headers => {"key" => "value"}, :body => {"key" => "value"}, "something_else" => "else"}
```
