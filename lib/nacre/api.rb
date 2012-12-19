require 'nacre'
require 'faraday'
require 'JSON'

module Nacre
  class Api
    attr_reader :config, :connection

    def initialize args
      @config = Nacre::Config.new(args)
      @connection = Nacre::Connection.new({
          auth_data: auth_data,
          auth_url: @config.auth_url,
          api_url: @config.api_url
      })
    end

    #def product
      #@product_service ||= Nacre::API::Product.new(self)
    #end

    #def order
      #@order_service ||= Nacre::API::Order.new(self)
    #end

    private
    
    def auth_data
        {
            apiAccountCredentials: {
                emailAddress: @config.email,
                password:     @config.password
            }
        }.to_json
    end

  end
end
