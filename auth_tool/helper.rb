require 'json'
require 'faraday'

f = File.new('client_secrets/client_secrets.json', 'r')
Client_secrets = JSON.parse(f.read).freeze

module AuthTool
  module Helper
    ##
    # Returns the configuration hash for the given API.
    #
    # @param [String] api_name
    #   The api you wish to authenticate against (i.e., twitter)
    #
    # @return [Hash] The configuration hash for api_name
    def self.read_secrets api_name
      raise "API not found" unless Client_secrets.has_key?(api_name.downcase)
      return Client_secrets[api_name.downcase]
    end

    ##
    # Returns a Faraday Connetion object
    # 
    # @param [Hash] params
    #   The additional parameters hash.
    #
    # @return [Faraday::Connection]
    def self.get_connection(params)
      connection = Faraday.new(:params => params)
      return connection
    end
  end
end
