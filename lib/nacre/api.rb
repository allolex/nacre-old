require 'nacre'
require 'psych'
require 'faraday'
require 'JSON'

require 'pp'

module Nacre

  class Api

    attr_reader :token, :config, :connection

    def initialize args
      @config = Nacre::Config.new args
      @connection = Faraday.new
      begin
        authenticate
      rescue
        puts "Authentication failure"
      end
    end

    def product
      @product ||= Nacre::Product.new( token: @auth_token )
    end

    def auth_url
      "#{@config.base_url}/#{@config.id}/authorise"
    end

  private

    def authenticate
      message = {
        apiAccountCredentials: {
              emailAddress: @config.email,
              password:     @config.password
        }
      }.to_json
      @current_response = @connection.post self.auth_url, message,
        { 'Content-Type' => 'application/json', 'Accept' => 'json' }
      @auth = JSON.parse(@current_response.body)
      @token = Nacre::Token.new(@auth['response'])
    end
  end
end

