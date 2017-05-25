require_relative 'auth_tool/client'
require_relative 'auth_tool/helper'
require_relative 'auth_tool/oauth_1'
require_relative 'auth_tool/oauth_2'

module Auth_tool

  def self.get_client api_name
    client = create_client(read_config(api_name))
    return client
  end

  def self.get_redirect_url client
    redirect_url = client.oauth_version == 1 ? Auth_tool::OAuth1.redirect_url(client) : Auth_tool::OAuth2.redirect_url(client)
    puts redirect_url
  end

  def self.receive(client, response)
    client.oauth_version == 1 ? receive_oauth1(client, response) : receive_oauth2(client,response)
  end

  private
  ##
  # Creates an OAuth client.
  #
  # @param [Hash] options
  #   Configuration options for the client.
  #
  # @return [Auth_tool::Client] New client object
  def create_client options
    Auth_tool::Client.new options
  end

  ##
  # Gets config hash for the given API
  #
  # @param [String] api_name
  #   The name of the API/Company as it appears in the database
  def read_config api_name
    Auth_tool::Helper.read_secrets(api_name)
  end

  def receive_oauth1(client, response)

  end

  def receive_oauth2(client, response)

  end
end
