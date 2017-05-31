require 'sinatra'
require_relative '../lib/auth_tool'
  #client = AuthTool::get_client 'github'
  client = AuthTool::get_client JSON.parse({ "client_id":"c1d4265302eba1aa4f37", "authorization_uri":"https://github.com/login/oauth/authorize", "token_credential_uri":"https://github.com/login/oauth/access_token", "client_secret":"7be3891166bdfc95193b20bf3e65dbf0844e2121", "oauth_version": "2", "redirect_uri": "http://localhost:4567/callback", "scope": "user" })
get '/' do
  redirect AuthTool::get_redirect_url client
end

get '/callback' do
  AuthTool::receive(client, params)
  puts client.to_json
  AuthTool::call(client,"get", "https://api.github.com/user")
end
