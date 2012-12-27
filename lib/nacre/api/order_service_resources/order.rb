require 'nacre'
require 'JSON'

module Nacre
  module API
    class Order < OrderServiceResource
      FIELDS = [
        :orderId, :orderTypeId, :contactId, :orderStatusId,
        :orderStockStatusId, :createdOn, :createdById
      ]

      def self.fields
        FIELDS
      end

      fields.each do |attr|
        attr_accessor attr
      end

      def initialize(values = nil)
        load_values(values) unless values.nil? || values.empty?
      end

      private

      def self.url
        service_url + "/order"
      end

      def self.search_url
        service_url + '/order-search'
      end
    end
  end
end
