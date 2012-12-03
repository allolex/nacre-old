require 'nacre'
require 'faraday'
require 'JSON'

module Nacre

  class Api

    attr_reader :token, :config, :connection

    def initialize args
      @config = Nacre::Config.new args
      @connection = Faraday.new
      begin
        authenticate
        self.config.header['brightpearl-auth'] = self.token.to_s
      rescue
        puts "Authentication failure"
      end
    end

    def auth_url
      endpoint = "#{self.config.base_url}/#{self.config.id}/authorise"
      endpoint
    end

  private

    def authenticate
      message = {
        apiAccountCredentials: {
              emailAddress: self.config.email,
              password:     self.config.password
        }
      }.to_json
      @current_response = @connection.post self.auth_url, message, self.config.header
      @auth = JSON.parse(@current_response.body)
      @token = Nacre::Token.new(@auth['response'])
    end
  end
end

