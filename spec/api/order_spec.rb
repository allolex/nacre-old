require 'spec_helper'

describe Nacre::API::Order do

  before :each do
    @config = 'config/test_config.yml'
    @api = Nacre::Api.new( file: @config )
    @order = Nacre::API::Order.new( @api )
  end

  it 'should allow an instance to be created' do
    @order.should be_a(Nacre::API::Order)
  end

  it 'should return a valid order API URL' do
    @order.url.to_s.should ==
      'https://ws-eu1.brightpearl.com/2.0.0/damonclone/order-service'
  end

  it 'should return a valid order search URL' do
    @order.search_url.to_s.should ==
      'https://ws-eu1.brightpearl.com/2.0.0/damonclone/order-service/order-search'
  end

  it 'should return a list of all orders' do
    puts @order.list.inspect
    @order.list.should be_a(Array)
    @order.list.first.should be_a(Nacre::API::OrderSearchResult)
  end

end
