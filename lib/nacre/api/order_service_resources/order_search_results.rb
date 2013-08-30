require 'nacre'
require 'json'
require 'ostruct'
require 'nacre/api/searchable'

module Nacre

  module API

    class OrderSearchResults

      include Nacre::API::Searchable

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


      def id_set
        @items.map(&:orderId)
      end
    end
  end
end
