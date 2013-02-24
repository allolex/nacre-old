require 'nacre'
require 'JSON'
require 'active_support/inflector'

module Nacre

  module API

    class ProductServiceResource < Nacre::API::ServiceResource

      def self.search(query = nil, args)
        args[:starting_page] = 2
        search = Nacre::API::ProductSearch.new(search_url, query, args)
        search_results = search.results
        results = find_many(search_results.id_set)
      end

      private

      def self.service_url
        "/product-service"
      end

    end
  end
end
