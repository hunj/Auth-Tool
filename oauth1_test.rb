require 'sinatra'
require_relative 'auth_tool'
  client = AuthTool::get_client 'twitter'
get '/' do
  redirect AuthTool::get_redirect_url client
end

get '/callback' do
  AuthTool::receive(client, params)
  AuthTool::call(client, "https://api.twitter.com/1.1/account/settings.json")
end
