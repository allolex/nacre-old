require 'nacre'
require 'JSON'
require 'active_support/inflector'

module Nacre

  module API

    class ProductServiceResource # Abstract Class

      def self.connection
          Nacre::Api.global_instance.connection
      end

      def self.find(id)
        find_many([id]).first
      end

      def self.all
          search
      end

      def self.search(query = nil)
        search = Nacre::API::ProductSearch.new(search_url, query)
        search_results = search.results
        find_many(search_results.id_set)
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

      #def self.search_results_class
        #raise NotImplementedError.new("Child class must implement #{method_name}")
      #end

      def self.find_many(id_set)
        results = []
        return [] if id_set.empty?

        id_set_string = id_set.join(",")
        begin
          response = self.connection.get("#{url}/#{id_set_string}")
        rescue
          raise "Error in response: #{response.try(:body).try(:inspect)}\n#{connection.inspect}"
        end

        hash = JSON.parse(response.body)
        hash['response'].each do |result|
          model = self.new(result)
          results << model
        end

        results
      end

      def load_values(values)
        self.class.fields.each do |field|
          self.public_send "#{field.to_s}=", values[field.to_s.camelize(:lower)].to_openstruct
        end
      end
    end
  end
end
