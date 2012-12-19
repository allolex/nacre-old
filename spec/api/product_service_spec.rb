require 'spec_helper'

describe Nacre::API::ProductService do

  before :each do
    @api = double("api")
    @product_service = Nacre::API::ProductService.new( @api )
  end

  it 'should allow an instance to be created' do
    @product_service.should be_a(Nacre::API::ProductService)
  end

  it 'should return a valid product API URL' do
    @product_service.url.to_s.should ==
      '/product-service'
  end

  it 'should return a valid product search URL' do
    @product_service.search_url.to_s.should ==
      '/product-service/product-search'
  end

  it 'should return a list of all products' do
    connection = double("connection")
    @api.should_receive(:connection).and_return(connection)

    @product_service.list.should be_a(Array)
    @product_service.list.first.should be_a(Nacre::API::Product)
  end

end
