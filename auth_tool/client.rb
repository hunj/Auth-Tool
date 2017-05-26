require 'signet/oauth_1/client'
require 'signet/oauth_2/client'

module AuthTool
  class Client
    ##
    # Creates either a signet OAuth 1.0 or 2.0 client with additional params.
    #
    # @param [Hash] options
    #   Configuration parameters for the client.
    def initialize(options)
      config = options
      @has_params = config.has_key?('params')
      self.oauth_version = config.delete('oauth_version')
      self.params = config.delete('params') if @has_params
      @oauth_version == 1 ? oauth1(config) : oauth2(config)
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
    # Returns the OAuth version for this client.
    #
    # @return [Integer] The OAuth version.
    def oauth_version
      return @oauth_version
    end

    ##
    # Returns the parameters hash for this client
    #
    # @return [Hash] The additional parameters.
    def params
      return @params
    end

    ##
    # Returns the signet OAuth object for this client
    #
    # @return [Signet::OAuth1::Client, Signet::OAuth2::Client] The signet OAuth object.
    def signet
      return @signet
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
