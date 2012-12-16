require 'nacre'

module Nacre

  module API

    class OrderSearchResult

      #  |   orderId              |   true   |   true   |   INTEGER   |   N/A   |   false
      #  |   orderTypeId          |   true   |   true   |   INTEGER
      #  |   contactId            |   true   |   true   |   INTEGER   |   N/A   |   false
      #  |   orderStatusId        |   true   |   true   |   INTEGER
      #  |   orderStockStatusId   |   true   |   true   |   INTEGER
      #  |   createdOn            |   true   |   true   |   PERIOD    |   N/A   |   false
      #  |   createdById          |   true   |   true   |   INTEGER   |   N/A   |   false

      @@fields = [ :order_id, :order_type_id, :contact_id,
        :order_status_id, :order_stock_status_id, :created_on,
        :created_by_id ]

      @@fields.each do |attr|
        attr_accessor attr
      end

      def initialize list
        load_values list
        return self
      end

      def fields
        @@fields
      end

      private

      def load_values list
        self.fields.each_with_index do |field, index|
          self.send "#{field.to_s}=", list[index]
        end
      end
    end

  end

end
