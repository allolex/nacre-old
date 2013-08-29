require 'nacre'
require 'json'
require 'uri'

module Nacre
  module API
    class OrderSearch
      def initialize(search_url, query = nil, max_results = 200, starting_page = 1)
        @search_url = search_url
        @query = query
        @params = build_params( max_results: max_results, starting_page: starting_page )
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

        Nacre::API::OrderSearchResults.new_from_json(response.body)
      end

      private

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
