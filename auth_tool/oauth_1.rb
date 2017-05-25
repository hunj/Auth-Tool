require_relative 'client'

module Auth_tool
  module OAuth1
    ##
    # Returns redirect url for user authentication with the service
    #
    # @param [Auth_tool::Client] client
    #   The auth_tool client object.
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
    def OAuth1.redirect_url(client,options = {})
      client.signet.fetch_temporary_credential!(options)
      url = client.signet.authorization_uri
      return url
    end
  end
end
