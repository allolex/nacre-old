require 'nacre'
require 'JSON'
require 'ostruct'

module Nacre

  module API

    class OrderSearchResults

      class OrderSearchResultItemBuilder

        def build_result_item(data, columns)
          result_item = OpenStruct.new
          columns.each_with_index do |column, index|
            attr_name = column["name"]
            result_item.send("#{attr_name}=", data[index])
          end

          result_item
        end
      end

      SEARCH_FIELDS = [
        :order_id, :order_type_id, :contact_id, :order_status_id,
        :order_stock_status_id, :created_on, :created_by_id
      ]

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
          items << OrderSearchResultItemBuilder.new.build_result_item(raw_result, metadata.columns)
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
        @items.map(&:orderId)
      end
    end
  end
end


# orderId               | true | true  | INTEGER       | N/A | false
# orderName             | true | true  | SEARCH_STRING | N/A | false
# SKU                     | true | true  | STRING        | N/A | false
# EAN                     | true | true  | STRING        | N/A | false
# UPC                     | true | true  | STRING        | N/A | false
# ISBN                    | true | true  | STRING        | N/A | false
# stockTracked            | true | true  | BOOLEAN       | N/A | false
# salesChannelName        | true | false | STRING        | N/A | false
# createdOn               | true | true  | PERIOD        | N/A | false
# updatedOn               | true | true  | PERIOD        | N/A | false
# brightpearlCategoryCode | true | true  | STRING        | N/A | false
# orderGroupId          | true | true  | INTEGER       | N/A | false
#
# [ 1000, "Misc item without VAT", "", nil, nil, nil, false,
#   "Brightpearl", "2007-05-29T10:42:08.000+01:00",
#   "2007-09-08T14:42:45.000+01:00", "276", 0 ]

