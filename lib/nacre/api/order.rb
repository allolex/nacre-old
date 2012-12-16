require 'nacre'
require 'JSON'

module Nacre

  module API

    class Order

      def initialize api
        @api = api
      end

      def url
        "#{@api.config.url}/order-service"
      end

      def search_url
        self.url + '/order-search'
      end

      def list
        results = []
        response = nil
        begin
          response = @api.connection.connection.get self.search_url, {}, @api.config.header
        rescue
          raise "Error in response: #{response.body.inspect}\n#{@api.inspect}"
        end
        puts '----------------'
        puts response.inspect
        puts '----------------'
        hash = JSON.parse response.body
        hash['response']['results'].each do |result|
          model = Nacre::API::OrderSearchResult.new result
          results << model
        end
        return results
      end
    end
  end
end
