require 'nacre'

module Nacre

  class Service::Product

    attr_reader :api

    def initialize api
      @api = api
    end

    def url
      "#{self.api.config.url}/product"
    end

    def search_url
      self.url + '/product-search'
    end

    def list
      response = self.api.connection.get self.search_url, self.api.config.header
    end

  end
end
