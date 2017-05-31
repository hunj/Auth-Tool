require 'signet/oauth_1/client'
require 'signet/oauth_2/client'
require 'json'

module AuthTool
  class Client
    ##
    # Creates either a signet OAuth 1.0 or 2.0 client with additional params.
    #
    # @param [Hash] options
    #   Configuration parameters for the client.
    def initialize(options, *credentials)
      config = options
      @has_params = config.has_key?('params')
      self.oauth_version = config.delete('oauth_version')
      self.params = config.delete('params') if @has_params
      if @oauth_version == 1
        oauth1 config
        self.signet.token_credential_key = credentials["oauth_token"] if credentials.has_key? "oauth_token"
        self.signet.token_credential_secret = credentials["oauth_token_secret"] if credentials.has_key? "oauth_token_secret"
      elsif @oauth_version == 2
        oauth2 config
        self.signet.access_token = credentials["oauth_token"] if credentials.has_key? "oauth_token"
        self.signet.refresh_token = credentials["refresh_token"] if credentialsl.has_key? "refresh_token" 
      else
        raise "Unexpected oauth_version: #{@oauth_version}"
      end

    end

    def oauth1 config
      config[:callback] = config.delete(:redirect_uri) if config.has_key?(:redirect_uri)
      self.signet = Signet::OAuth1::Client.new(config)
    end

    def oauth2 config
      config[:redirect_uri] = config.delete(:callback) if config.has_key?(:callback)
      self.signet = Signet::OAuth2::Client.new(config)
      @signet.additional_parameters = @params if @has_params
    end

    ##
    # Attempts to refresh the access token of the client
    def self.refresh
      raise "Incorrect OAuth Version" if @oauth_version != 2
      raise "Missing Refresh Token" if self.signet.refresh_token == nil
      self.signet.refresh!
    end

    ##
    # Returns the OAuth version for this client.
    #
    # @return [Integer] The OAuth version.
    def oauth_version
      return @oauth_version
    end

    ##
    # Returns the parameters hash for this client.
    #
    # @return [Hash] The additional parameters.
    def params
      return @params
    end

    ##
    # Returns the signet OAuth object for this client.
    #
    # @return [Signet::OAuth1::Client, Signet::OAuth2::Client] The signet OAuth object.
    def signet
      return @signet
    end

    ##
    # Returns the final authentication token for the client.
    #
    # @return [Hash] The token.
    def token
      @token
    end

    ##
    # Sets the final authentication token for the client.
    #
    # @param [Hash] token
    #   The hash containing the token & secret or the token and refresh token.
    def token= token
      @token = token
    end

    ##
    # Returns if the client has additional parameters.
    #
    # @return [Boolean] If the client has additional params.
    def has_params?
      return @has_params
    end
    private
    ##
    # Sets the oauth_version for this client.
    #
    # @param [String] oauth_version
    #   OAuth version of the API.
    def oauth_version=(oauth_version)
      raise "Missing OAuth version parameter" unless !oauth_version.is_a? NilClass
      raise "OAuth Version must be 1 or 2" unless oauth_version.to_i == 1 || oauth_version.to_i == 2
      @oauth_version = oauth_version.to_i
    end
    ##
    # Sets the parameters hash for this client.
    #
    # @param [Hash] params
    #   The parameters hash.
    def params=(params)
      raise "Expected Hash, got #{params.class}." unless params.is_a? Hash
      @params = params
    end

    ##
    # Sets the signet OAuth client for this client.
    #
    # @param [Signet::OAuth1::Client, Signet::OAuth2::Client] signet
    #   The signet client object.
    def signet=(signet)
      @signet = signet
    end
  end
end
