require_relative 'auth_tool/client'
require_relative 'auth_tool/helper'
require_relative 'auth_tool/oauth_1'
require_relative 'auth_tool/oauth_2'

module Auth_tool
  ##
  # Creates a client object for the specified API.
  #
  # @param [String] api_name
  #   The name of the API/company.
  #
  # @return [Auth_tool::Client] The client.
  def self.get_client api_name
    client = create_client(read_config(api_name))
    return client
  end

  ##
  # Returns the redirect url so the user can authenticate with the service.
  #
  # @param [Auth_tool::Client] client
  #   The client containing the API information.
  #
  # @return [String] The redirect url.
  def self.get_redirect_url client
    redirect_url = client.oauth_version == 1 ? Auth_tool::OAuth1.redirect_url(client) : Auth_tool::OAuth2.redirect_url(client)
    return redirect_url
  end

  ##
  # Handles service's user authentication response delivered by the front-end.
  #
  # @param [Auth_tool::Client] client
  #   The client containing the API information.
  #
  # @param [String] response
  #   The service's response to the callback url
  def self.receive(client, response)
    client.oauth_version == 1 ? receive_oauth1(client, response) : receive_oauth2(client,response)
  end

  # Refresh Token method for OAuth2

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

  ##
  # Handles OAuth 1.0 callback procedure.
  # Called by Auth_tool::receive.
  #
  # @param [Auth_tool::Client] client
  #   The client containing the API information.
  #
  # @param [String] response
  #   The response to the callback url
  def receive_oauth1(client, response)
    # response is verification
  end

  ##
  # Handles OAuth 2.0 callback procedure
  # Called by Auth_tool::receive.
  #
  # @param [Auth_tool::Client] client
  #   The client containing the API information.
  #
  # @param [String] response
  #   The response to the callback url
  def receive_oauth2(client, response)
    # client.signet.code=response[:code]
    # client.signet.fetch_access_token!
  end
end
