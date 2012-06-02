require 'nacre'
require 'psych'
require 'rest-client'
require 'json'

require 'pp'

module Nacre

  class Api

    attr_reader :email, :id, :auth_token, :distribution_centre, :api_version

    def initialize args
      if args[:config] && File.exists?(args[:config])
        load_config args[:config]
      end
      @email    ||= args[:email]
      @id       ||= args[:id]
      @password ||= args[:password]
      if @email =~ /@/ && password.respond_to?(:to_s)
        puts "Authenticating"
        begin
          authenticate
        rescue
          puts "Authentication failure"
        end
      end
    end

    def product
      @product ||= Product.new( token: @auth_token )
    end

  private

    def password
      @password
    end

    def load_config file
      config = Psych.load( File.open(file,'r').read )
      @email = config['email']
      @id = config['id']
      @password = config['password']
      @distribution_centre = config['distribution_centre']
      @api_version = config['api_version']
    end

    def authenticate
      @auth_token = nil
      uri = URI.parse( "https://ws-%s.brightpearl.com/%s/authorise" % [@distribution_centre, @id] )
      message = {
        apiAccountCredentials: {
              emailAddress: @email,
              password:     @password
        }
      }.to_json
      response = RestClient.post uri.to_s, message, :content_type => :json, :accept => :json
      auth = JSON.parse(response.body)
      @auth_token = Token.new(auth['response'])
    end
  end
end

