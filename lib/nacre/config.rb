require 'psych'

module Nacre

  class Config

    REQUIRED = [:email, :id, :password, :distribution_centre, :api_version, :file]

    REQUIRED.each do |attr|
      attr_accessor attr
    end

    attr_accessor :header

    def initialize(args)
      if File.exists? args[:file]
        load_file args[:file]
      end
      load_values args
      REQUIRED.each do |method|
        raise "#{method.to_s} required" unless validates? method
      end
      @header = { 'Content-Type' => 'application/json', 'Accept' => 'json' }
    end

    def base_url
       URI.parse( "https://ws-%s.brightpearl.com" % [self.distribution_centre] )
    end

    def url
      self.base_url + "/#{api_version}/#{id}"
    end

  private

    def load_file file
      config = Psych.load( File.open(file,'r').read )
      load_values config
      return true
    end

    def load_values hash
      hash.each do |key,value|
        self.send "#{key.to_s}=", value
      end
      return true
    end

    def validates? method
      return true if self.send(method).length > 1
    end
  end
end
