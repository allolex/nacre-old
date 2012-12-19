require 'nacre'
require 'JSON'

module Nacre

  module API

    class ProductService

      def initialize api
        @api = api
      end

      def url
        "#{@api.config.url}/product-service"
      end

      def search_url
        self.url + '/product-search'
      end

      def list
        results = []
        response = nil
        begin
          response = @api.connection.connection.get self.search_url, {}, @api.config.header
        rescue
          raise "Error in response: #{response.body.inspect}\n#{@api.inspect}"
        end
        hash = JSON.parse response.body
        hash['response']['results'].each do |result|
          model = Nacre::API::ProductSearchResult.new result
          results << model
        end
        return results
      end
    end
  end
end
