require 'nacre'
require 'json'

module Nacre
  module API
    class ProductSearch
      def initialize(search_url, query = nil)
        @search_url = search_url
        @query = query
      end

      def self.connection
        Nacre::Api.global_instance.connection
      end

      def results
        begin
          response = self.class.connection.get("#{@search_url}#{@query}")
        rescue
          raise "Error in response: #{response.try(:body).try(:inspect)}\n#{connection.inspect}"
        end

        Nacre::API::ProductSearchResults.new_from_json(response.body)
      end

    end
  end
end
