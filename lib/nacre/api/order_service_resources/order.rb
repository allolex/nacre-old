require 'nacre'
require 'json'
require 'active_support/inflector'

module Nacre

  module API

    class Order < OrderServiceResource

      FIELDS = [
        :id,
        :parentOrderId,
        :orderTypeCode,
        :reference,
        :acknowledged,
        :orderStatus,
        :stockStatusCode,
        :allocationStatusCode,
        :placedOn,
        :createdOn,
        :createdById,
        :priceListId,
        :priceModeCode,
        :delivery,
        :invoices,
        :currency,
        :totalValue,
        :assignment,
        :parties,
        :orderRows
      ]

      def self.fields
        FIELDS.map(&:to_s).map(&:underscore).map(&:to_sym)
      end

      fields.each do |attr|
        attr_accessor attr.to_s.underscore.to_sym
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
