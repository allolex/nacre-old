require 'nacre'
require 'rest-client'
require 'json'

module Nacre

  class Service

    attr_reader :name, :request_uri, :search_uri

    def initialize config
      @config = config
      @name = caller.class
      @request_uri = URI.join( "https://ws-#{@config['distribution_centre']}.brightpearl.com/",
                            @config[api_version],
                            @config['id'],
                            self.service_name )
      @search_uri = URI.join( @request_uri, self.search_name )
    end

    def search_name
      @name + '-search'
    end

    def service_name
      @name + '-service'
    end

    def get uri
      response = RestClient.get(
                   uri,
                   { :content_type      => :json,
                     :accept            => :json,
                     'brightpearl-auth' => @auth_token }
                 )
      result = JSON.parse(response)
    end

    def list

    end
  end
end
