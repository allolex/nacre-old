require 'spec_helper'

describe Nacre::API::ProductService do

  before :each do
    @config = test_config_file
    @api = Nacre::Api.new( file: @config )
    @product_service = Nacre::API::ProductService.new( @api )
  end

  it 'should allow an instance to be created' do
    @product_service.should be_a(Nacre::API::ProductService)
  end

  it 'should return a valid product API URL' do
    @product_service.url.to_s.should ==
      'https://ws-eu1.brightpearl.com/2.0.0/your_brightpearl_id/product-service'
  end

  it 'should return a valid product search URL' do
    @product_service.search_url.to_s.should ==
      'https://ws-eu1.brightpearl.com/2.0.0/your_brightpearl_id/product-service/product-search'
  end

  it 'should return a list of all products' do
    @product_service.list.should be_a(Array)
    @product_service.list.first.should be_a(Nacre::API::Product)
  end

end
