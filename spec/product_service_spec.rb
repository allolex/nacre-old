require 'spec_helper'

describe Nacre::ProductService do

  describe 'should' do

    before :each do
      @config = 'config/test_config.yml'
      @bp = Nacre::Api.new( file: @config )
      @product = Nacre::ProductService.new( @bp )
    end

    it 'allow an instance to be created' do
      @product.should be_a(Nacre::ProductService)
    end

    it 'allow access to configuration' do
      @product.api.should be_a(Nacre::Api)
    end

    it 'return a valid product API URL' do
      @product.url.to_s.should ==
        'https://ws-eu1.brightpearl.com/2.0.0/allolex/product-service'
    end

    it 'return a valid product search URL' do
      @product.search_url.to_s.should ==
        'https://ws-eu1.brightpearl.com/2.0.0/allolex/product-service/product-search'
    end

    it 'return a list of products when using the "list" method' do
      @product.list.should be_a(Array)
      @product.list.first.should be_a(Nacre::ProductModel)
    end
  end
end
