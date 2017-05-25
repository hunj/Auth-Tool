require_relative 'client'

module Auth_tool
  module OAuth2
    ##
    # Returns redirect url for user authentication with the service
    #
    # @param [Auth_tool::Client] client
    #   The auth_tool client object.
    #
    # @return [String] The url to redirect to.
    def OAuth2.redirect_url client
      url = client.signet.authorization_uri
      return url
    end
  end
end
