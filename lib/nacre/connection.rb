require 'faraday'

module Nacre

  class Connection

    attr_accessor :connection

    def initialize
      @connection = Faraday.new
    end

    def token= token
      @connection.headers['brightpearl-auth'] = token
    end

    def token
      @connection.headers['brightpearl-auth']
    end

    def content_type= type
      @connection.headers['Content-Type'] = type
    end

    def content_type
      @connection.headers['Content-Type']
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

    def authenticate
      message = {
        apiAccountCredentials: {
          emailAddress: self.config.email,
          password:     self.config.password
        }
      }.to_json
      @current_response = @connection.connection.post self.auth_url, message, self.config.header
      @auth = JSON.parse(@current_response.body)
      @token = @connection.token = Nacre::Token.new(@auth['response'])
    end

  end
end
