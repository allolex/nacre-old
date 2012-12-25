require 'nacre'
require 'JSON'

module Nacre
  module API
    class ProductServiceResource # Abstract Class
      def self.connection
          Nacre::Api.global_instance.connection
      end

      def self.all
          search
      end

      def self.search(params = nil)
        results = []
        response = nil

        begin
          response = self.connection.get("#{search_url}#{params}")
        rescue
          raise "Error in response: #{response.body.inspect}\n#{api.inspect}"
        end

        hash = JSON.parse(response.body)
        hash['response'].each do |result|
          model = self.new(result)
          results << model
        end
        
        results
      end

    private

      def self.service_url
        "/product-service"
      end

      def self.url
        raise NotImplementedError.new("Child class must implement #{method_name}")
      end

      def self.search_url
        raise NotImplementedError.new("Child class must implement #{method_name}")
      end

      def load_values(values)
        self.fields.each_with_index do |field, index|
          self.public_send "#{field.to_s}=", values[index]
        end
      end
    end
  end
end
