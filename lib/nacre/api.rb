require 'nacre'
require 'faraday'
require 'JSON'

module Nacre

  class Api

    attr_reader :token, :config, :connection

    def initialize args
      @config = Nacre::Config.new args
      @connection = Nacre::Connection.new
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

    def product
      @product ||= Nacre::API::Product.new(self)
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

