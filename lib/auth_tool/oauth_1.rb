require_relative 'client'
require 'json'
require 'faraday'

module AuthTool
  module OAuth1
    ##
    # Returns redirect url for user authentication with the service
    #
    # @param [AuthTool::Client] client
    #   The AuthTool Client object.
    #
    # @param [Hash] options
    #   The signet configuration options.
    #   - :signature_method
    #     The signature method. Defaults to 'HMAC-SHA1'.
    #   - :additional_parameters
    #     Non-standard additional parameters.
    #   - :realm
    #     The Authorization realm. See RFC 2617.
    #   - :connection
    #     The HTTP connection to use.
    #     Must be of type Faraday::Connection
    #
    # @return [String] The url to redirect to.
    def self.redirect_url(client,options = {})
      client.signet.fetch_temporary_credential!(options)
      url = client.signet.authorization_uri
      return url
    end

    ##
    # Handles OAuth 1.0 callback procedure.
    # Called by AuthTool::receive.
    #
    # @param [AuthTool::Client] client
    #   The client containing the API information.
    #
    # @param [Hash] response
    #   The response to the callback url (verification information).
    def self.receive(client, response)
      verifier = response['oauth_verifier'] if response.has_key?('oauth_verifier')
      verifier = response[:oauth_verifier] if response.has_key?(:oauth_verifier)
      credential = client.signet.fetch_token_credential!(:verifier => verifier)
      client.token = credential.to_hash
    end

    ##
    # Makes an authenticated call to the API resource.
    # Called by AuthTool::call.
    #
    # @param [AuthTool::Client] client
    #   The client containing the API information.
    #
    # @param [String] uri
    #   The API endpoint to hit.
    #
    # @param [Hash] params
    #   Hash of additional parameters for the call.
    #
    # @return [Hash] The endpoint's response.
    def self.call(client, http_verb = 'get', uri, params)
      header = params.delete('header') if params.has_key? 'header'
      body = params.delete('body') if params.has_key? 'body'
      conn = Faraday.new(:params => params)
      options = {:method => http_verb, :header => header, :body => body, :uri => uri, :connection => conn}
      response = client.signet.fetch_protected_resource(options)
      return JSON.parse(response.body)
    end
  end
end
