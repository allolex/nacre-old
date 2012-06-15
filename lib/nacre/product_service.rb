require 'nacre'
require 'JSON'

module Nacre

  class ProductService

    attr_reader :api

    def initialize api
      @api = api
    end

    def url
      "#{self.api.config.url}/product-service"
    end

    def search_url
      self.url + '/product-search'
    end

    def list
      results = []
      self.api.connection.headers['brightpearl-auth'] = self.api.token.to_s
      self.api.connection.headers['Content-Type'] = 'application/json'
      response = self.api.connection.get self.search_url, {}
      hash = JSON.parse response.body
      hash['response']['results'].each do |result|
        model = Nacre::ProductSearchResult.new result
        results << model
      end
      return results
    end

  end
end
