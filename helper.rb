require 'json'

File = File.new('client_secrets/client_secrets.json', 'r').freeze
Client_secrets = JSON.parse(file.read).freeze

module Helper
  ##
  # Returns client_secrets hash for the given API
  #
  # @param [String] api_name
  #   The api you wish to authenticate against (i.e., twitter)
  #
  # @return [hash] The relevant hash in client_secrets.json
  def read_secrets api_name
    raise "API not found" unless Client_secrets.has_key?(api_name.downcase)
    return
  end

end
