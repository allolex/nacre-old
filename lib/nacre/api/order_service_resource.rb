module Nacre

  module API

    class OrderServiceResource < Nacre::API::ServiceResource

      def self.search(query = nil)
        search = Nacre::API::OrderSearch.new(search_url, query)
        search_results = search.results
        find_many(search_results.id_set)
      end

      private

      def self.service_url
        "/order-service"
      end

    end
  end
end
