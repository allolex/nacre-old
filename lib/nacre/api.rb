require 'nacre'
require 'faraday'
require 'json'

module Nacre
  class Api
    attr_reader :config, :connection

    @@global_instance = nil

    def initialize args
      @config = Nacre::Config.new(args)
      @connection = Nacre::Connection.new({
          auth_data: auth_data,
          auth_url: @config.auth_url,
          api_url: @config.api_url
      })

      @connection.authenticate

      @@global_instance = self # FIXME hack to make the api object a singleton
    end

    def self.global_instance
        @@global_instance || raise("Nacre API not initialized")
    end

    private

    def auth_data
        {
            apiAccountCredentials: {
                emailAddress: @config.email,
                password:     @config.password
            }
        }
    end

  end
end
