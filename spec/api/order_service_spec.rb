require 'spec_helper'

describe Nacre::API::OrderService do

  before :each do
    @config = 'config/test_config.yml'
    @api = Nacre::Api.new( file: @config )
    @order_service = Nacre::API::OrderService.new( @api )
  end

  it 'should allow an instance to be created' do
    @order_service.should be_a(Nacre::API::OrderService)
  end

  it 'should return a valid order API URL' do
    @order_service.url.to_s.should ==
      'https://ws-eu1.brightpearl.com/2.0.0/your_brightpearl_id/order-service'
  end

  it 'should return a valid order search URL' do
    @order_service.search_url.to_s.should ==
      'https://ws-eu1.brightpearl.com/2.0.0/your_brightpearl_id/order-service/order-search'
  end

  it 'should return a list of all orders' do
    @order_service.list.should be_a(Array)
    @order_service.list.first.should be_a(Nacre::API::Order)
  end

end
