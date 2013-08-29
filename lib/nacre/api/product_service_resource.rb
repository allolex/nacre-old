require 'nacre'
require 'json'
require 'active_support/inflector'

module Nacre

  module API

    class ProductServiceResource < Nacre::API::ServiceResource

      def self.search(query = nil)
        search = Nacre::API::ProductSearch.new(search_url, query)
        search_results = search.results
        find_many(search_results.id_set)
      end

      private

      def self.service_url
        "/product-service"
      end

    end
  end
end
