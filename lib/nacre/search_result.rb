module Nacre

  class SearchResult

    attr_reader :fields

    @@fields = []

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
