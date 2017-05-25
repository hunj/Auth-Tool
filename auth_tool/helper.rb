require 'json'

f = File.new('client_secrets/client_secrets.json', 'r')
Client_secrets = JSON.parse(f.read).freeze

module Auth_tool
  module Helper
    ##
    # Returns the configuration hash for the given API.
    #
    # @param [String] api_name
    #   The api you wish to authenticate against (i.e., twitter)
    #
    # @return [Hash] The configuration hash for api_name
    def Helper.read_secrets api_name
      raise "API not found" unless Client_secrets.has_key?(api_name.downcase)
      return Client_secrets[api_name.downcase]
    end
  end
end
