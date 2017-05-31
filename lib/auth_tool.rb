require_relative 'auth_tool/client'
require_relative 'auth_tool/helper'
require_relative 'auth_tool/oauth_1'
require_relative 'auth_tool/oauth_2'

module AuthTool
  ##
  # Creates a client object for the specified API.
  #
  # @param [String] api_name
  #   The name of the API/company.
  #
  # @return [AuthTool::Client] The client.
  def self.get_client api_name
    client = create_client(read_config(api_name))
    return client
  end

  ##
  # Returns the redirect url so the user can authenticate with the service.
  #
  # @param [AuthTool::Client] client
  #   The client containing the API information.
  #
  # @return [String] The redirect url.
  def self.get_redirect_url client
    params = client.params if client.has_params?
    params ||= {}
    redirect_url = client.oauth_version == 1 ? AuthTool::OAuth1.redirect_url(client, params) : AuthTool::OAuth2.redirect_url(client)
    return redirect_url
  end

  ##
  # Handles service's user authentication response delivered by the front-end.
  # Sets the client's access_token.
  #
  # @param [AuthTool::Client] client
  #   The client containing the API information.
  #
  # @param [String] response
  #   The service's response to the callback url
  def self.receive(client, response)
    client.oauth_version == 1 ? AuthTool::OAuth1.receive(client, response) : AuthTool::OAuth2.receive(client,response)
  end

  ##
  # Returns the authentication token information of the client
  #
  # @param [AuthTool::Client] client
  #   The client.
  #
  # @return [Hash] The token hash for the client.
  def self.get_token client
    return client.token
  end

  ##
  # Attempts to refresh the auth token for the client
  #
  # @param [AuthTool::Client] client
  def self.refresh client
    client.refresh
  end

  ##
  # Makes an authenticated call to the API resource.
  #
  # @param [AuthTool::Client] client
  #   The client containing the API information.
  #
  # @param [String] uri
  #   The API endpoint to hit.
  #
  # @param [Hash] params
  #   Optional. Hash of additional parameters for the call.
  #
  # @return [Hash] The endpoint's response.
  #
  # @example
  #   response = AuthTool.call(
  #     client, "get", "https://api.twitter.com/1.1/users/show.json",
  #       {:screen_name => "username"})
  def self.call(client, http_verb, uri, params = {})
    response = client.oauth_version == 1 ? AuthTool::OAuth1.call(client, http_verb, uri, params) : AuthTool::OAuth2.call(client, http_verb, uri, params)
    return response
  end

  # TODO: Refresh Token method for OAuth2

  private
  ##
  # Creates an OAuth client.
  #
  # @param [Hash] options
  #   Configuration options for the client.
  #
  # @return [AuthTool::Client] New client object
  def self.create_client options
    AuthTool::Client.new options
  end

  ##
  # Gets config hash for the given API
  #
  # @param [String] api_name
  #   The name of the API/Company as it appears in the database
  def self.read_config api_name
    AuthTool::Helper.read_secrets(api_name)
  end
end
