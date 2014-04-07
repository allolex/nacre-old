require 'psych'

module Nacre
  class Config

    REQUIRED = [:email, :id, :password, :distribution_centre, :api_version, :file]

    REQUIRED.each do |attr|
      attr_accessor attr
    end

    attr_accessor :base_url

    def initialize(args)
      @base_url = args[:base_url]

      filename = args[:file]
      if !!filename
          if File.exists?(filename)
            self.file = filename
            load_file filename
          else
            raise "File not found"
          end
      end
      load_values args

      REQUIRED.each do |field|
        raise "#{field.to_s} required" unless has_been_set? field
      end
    end

    def base_url
        url = "https://ws-%s.brightpearl.com" % [self.distribution_centre]
        url = @base_url if @base_url
        URI.parse(url)
    end

    def api_url
      base_url + "/#{api_version}/#{id}"
    end

    def auth_url
      base_url + "/#{id}/authorise"
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

    def has_been_set? field
      field_value = self.send(field)
      field_value && !field_value.empty?
    end
  end
end
