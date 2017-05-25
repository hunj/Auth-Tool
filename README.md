Auth_tool
===
General purpose OAuth tool for API integrations. Utilizes [signet](https://github.com/google/signet).
Usage
---
```
require 'auth_tool'

client = Auth_tool::get_client 'twitter'
Auth_tool::get_redirect_url client

# receive data from front-end

token = Auth_tool::receive(client,response)
```
