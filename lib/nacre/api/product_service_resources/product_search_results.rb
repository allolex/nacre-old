require 'nacre'
require 'json'
require 'ostruct'

module Nacre

  module API

    class ProductSearchResults

      class ProductSearchResultItemBuilder

        def build_result_item(data, columns)
          result_item = OpenStruct.new
          columns.each_with_index do |column, index|
            attr_name = column["name"]
            result_item.send("#{attr_name}=", data[index])
          end

          result_item
        end

      end

      SEARCH_FIELDS = [ :product_id, :product_name, :sku, :ean, :upc, :isbn,
        :stock_tracked, :sales_channel, :created, :updated,
        :bp_category, :product_group ]

      SEARCH_FIELDS.each do |attr|
        attr_accessor attr
      end

      attr_accessor :metadata, :items

      def initialize(metadata = nil, items = [])
        @items = items
        @metadata = metadata
      end

      def self.new_from_json(json)
        items = []
        data = JSON.parse(json)
        response = data['response']
        metadata = OpenStruct.new(response['metaData'])
        raw_results = response['results']
        raw_results.each do |raw_result|
          items << ProductSearchResultItemBuilder.new.build_result_item(raw_result, metadata.columns)
        end

        self.new(metadata, items)
      end

      def length
        @items.length
      end

      def empty?
        @items.empty?
      end

      def id_set
        @items.map(&:productId)
      end
    end
  end
end
