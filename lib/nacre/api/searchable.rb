module Nacre

  module API

    module Searchable

      def self.included base
        base.send :include, InstanceMethods
        base.extend ClassMethods
      end

      class ItemBuilder

        def build_result_item(data, columns)
          result_item = OpenStruct.new
          columns.each_with_index do |column, index|
            attr_name = column["name"]
            result_item.send("#{attr_name}=", data[index])
          end

          result_item
        end

      end

      module InstanceMethods

        def length
          @items.length
        end

        def empty?
          @items.empty?
        end

      end

      module ClassMethods

        def new_from_json(json)
          items = []
          data = JSON.parse(json)
          response = data['response']
          metadata = OpenStruct.new(response['metaData'])
          raw_results = response['results']
          raw_results.each do |raw_result|
            items << Nacre::API::Searchable::ItemBuilder.new.build_result_item(raw_result, metadata.columns)
          end

          self.new(metadata, items)
        end

      end

    end
  end
end
