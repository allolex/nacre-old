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
end
