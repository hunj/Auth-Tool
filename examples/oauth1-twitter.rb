require 'sinatra'
require_relative '../lib/auth_tool'
  #client = AuthTool::get_client 'twitter'
  client = AuthTool::get_client({"temporary_credential_uri" => "https://api.twitter.com/oauth/request_token", "authorization_uri" => "https://api.twitter.com/oauth/authorize", "token_credential_uri" => "https://api.twitter.com/oauth/access_token", "client_credential_key" => "ajkMgzvyhFwZV9hBgQjlW0rrG", "client_credential_secret" => "BKorJt4MRMpGxCGXNWGz0nFBhd7XfRx3vOHQpL24LKImcLlKXU", "callback" => "http://localhost:4567/callback", "verifier" => "oauth_verifier", "oauth_version" => "1" })

get '/' do
  redirect AuthTool::get_redirect_url client
end

get '/callback' do
  AuthTool::receive(client, params)
  AuthTool::call(client,"get", "https://api.twitter.com/1.1/account/settings.json")
end
