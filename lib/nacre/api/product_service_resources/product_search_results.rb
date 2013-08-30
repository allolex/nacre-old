require 'nacre'
require 'json'
require 'ostruct'
require 'nacre/api/searchable'

module Nacre

  module API

    class ProductSearchResults

      include Nacre::API::Searchable

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

      def id_set
        @items.map(&:productId)
      end
    end
  end
end
