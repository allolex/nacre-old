require 'faraday'

module Nacre
  class Connection
    attr_accessor :connection

    def initialize(params)
      @auth_url = params[:auth_url]
      @api_url = params[:api_url]
      @auth_data = params[:auth_data]

      @header_base = { 
        'Content-Type' => 'application/json', 
        'Accept' => 'json' 
      }

      @connection = Faraday.new
      @connection.headers['Content-Type'] = 'application/json'
    end

    def token= token
      @connection.headers['brightpearl-auth'] = token
    end

    def token
      @connection.headers['brightpearl-auth']
    end

    def authenticate
      current_response = @connection.post(@auth_url, @auth_data.to_json, @header_base)

      auth = JSON.parse(current_response.body)
      @token = Nacre::Token.new(auth['response']) #should use "try"
    end


  end

  class WIPConnection
    def initialize args
      begin
        authenticate
        self.config.header['brightpearl-auth'] = self.connection.token.to_s
      rescue
        puts "Authentication failure"
      end
    end

    def auth_url
      endpoint = "#{self.config.base_url}/#{self.config.id}/authorise"
      endpoint
    end

    def set_headers
      @connection.token = self.token.to_s
      @connection.content_type = 'application/json'
    end

    private


  end
end
