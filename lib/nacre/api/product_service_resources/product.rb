require 'nacre'
require 'JSON'

module Nacre
  module API
    class Product < ProductServiceResource
      @@fields = [ :product_id, :product_name, :sku, :ean, :upc, :isbn,
        :stock_tracked, :sales_channel, :created, :updated,
        :bp_category, :product_group ]

      @@fields.each do |attr|
        attr_accessor attr
      end

      # is this a hash or array of fields??
      def initialize(values = nil)
        load_values(values) unless values.nil? || values.empty?
        self  # is this necessary?
      end

      def fields
        @@fields
      end

      private

      def self.url
        service_url + "/product"
      end

      def self.search_url
        service_url + '/product-search'
      end
    end
  end
end


# productId               | true | true  | INTEGER       | N/A | false
# productName             | true | true  | SEARCH_STRING | N/A | false
# SKU                     | true | true  | STRING        | N/A | false
# EAN                     | true | true  | STRING        | N/A | false
# UPC                     | true | true  | STRING        | N/A | false
# ISBN                    | true | true  | STRING        | N/A | false
# stockTracked            | true | true  | BOOLEAN       | N/A | false
# salesChannelName        | true | false | STRING        | N/A | false
# createdOn               | true | true  | PERIOD        | N/A | false
# updatedOn               | true | true  | PERIOD        | N/A | false
# brightpearlCategoryCode | true | true  | STRING        | N/A | false
# productGroupId          | true | true  | INTEGER       | N/A | false
#
# [ 1000, "Misc item without VAT", "", nil, nil, nil, false,
#   "Brightpearl", "2007-05-29T10:42:08.000+01:00",
#   "2007-09-08T14:42:45.000+01:00", "276", 0 ]

