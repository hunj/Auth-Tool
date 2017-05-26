require 'sinatra'
require_relative '../auth_tool'
  client = AuthTool::get_client 'github'
get '/' do
  redirect AuthTool::get_redirect_url client
end

get '/callback' do
  AuthTool::receive(client, params)
  AuthTool::call(client, "https://api.github.com/user")
end
