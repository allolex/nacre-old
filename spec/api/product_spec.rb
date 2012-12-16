require 'spec_helper'

describe Nacre::API::Product do

  before :each do
    @config = 'config/test_config.yml'
    @api = Nacre::Api.new( file: @config )
    @product = Nacre::API::Product.new( @api )
  end

  it 'should allow an instance to be created' do
    @product.should be_a(Nacre::API::Product)
  end

  it 'should return a valid product API URL' do
    @product.url.to_s.should ==
      'https://ws-eu1.brightpearl.com/2.0.0/allolex/product-service'
  end

  it 'should return a valid product search URL' do
    @product.search_url.to_s.should ==
      'https://ws-eu1.brightpearl.com/2.0.0/allolex/product-service/product-search'
  end

end
