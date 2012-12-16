require 'nacre'
require 'JSON'

module Nacre

  module API

    class Product

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
        response = self.api.connection.get self.search_url, {}
        hash = JSON.parse response.body
        hash['response']['results'].each do |result|
          model = Nacre::ProductSearchResult.new result
          results << model
        end
        return results
      end
    end
  end
end
