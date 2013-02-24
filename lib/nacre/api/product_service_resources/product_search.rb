require 'nacre'
require 'JSON'

module Nacre
  module API
    class ProductSearch
      def initialize(search_url, query = nil, args)
        @search_url = search_url
        @query      = query
        @params     = build_params(
                        max_results: args[:max_results] || default_maximum_results,
                        starting_page: args[:starting_page] || default_starting_page
                      )
      end

      def self.connection
        Nacre::Api.global_instance.connection
      end

      def results
        begin
          uri = build_uri @search_url, @query, @params
          response = self.class.connection.get(uri)
        rescue
          raise "Error in response: #{response.try(:body).try(:inspect)}\n#{connection.inspect}"
        end

        Nacre::API::ProductSearchResults.new_from_json(response.body)
      end

      private

      def default_maximum_results
        200
      end

      def default_starting_page
        1
      end

      def build_uri search_url, query, params
        formatted_query = query.nil? ? '' : URI.escape(query + '&')
        "#{search_url}?#{formatted_query}#{params}"
      end

      def build_params args
        list = []
        args.each_pair do |param,value|
          list << "#{map_to_bp_param(param)}=#{value}" unless value.nil?
        end
        URI.escape(list.join('&'))
      end

      def map_to_bp_param param_key
        bp_map = {
          max_results: 'pageSize',
          starting_page: 'firstResult'
        }
        bp_map[param_key] || param_key.to_s
      end

    end
  end
end
