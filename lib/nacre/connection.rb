require 'faraday'

module Nacre

  class Connection

    attr_accessor :connection

    def initialize
      @connection = Faraday.new
    end
  end
end
