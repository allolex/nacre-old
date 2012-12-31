require 'nacre'
require 'JSON'

module Nacre

  module API

    class Product < ProductServiceResource

      FIELDS = [
        :id, :brandId, :productTypeId, :identity,
        :productGroupId, :stock, :financialDetails,
        :salesChannels, :composition, :variations
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
        service_url + "/product"
      end

      def self.search_url
        service_url + '/product-search'
      end
    end
  end
end
