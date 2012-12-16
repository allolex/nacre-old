require 'spec_helper'

describe Nacre::API::ProductSearchResult do

  before :all do
    @config = 'config/test_config.yml'
    @api = Nacre::Api.new( file: @config )
    @list = [ 1000, "Misc item without VAT", "", nil, nil, nil, false,
              "Brightpearl", "2007-05-29T10:42:08.000+01:00",
              "2007-09-08T14:42:45.000+01:00", "276", 0 ]
    @model = Nacre::API::ProductSearchResult.new @list
  end

  it 'should be possible to instantiate the class' do
    @model.should be_a(Nacre::API::ProductSearchResult)
  end

  it 'should have a list of fields' do
    @model.fields.should == [ :product_id, :product_name, :sku, :ean, :upc, :isbn,
                              :stock_tracked, :sales_channel, :created, :updated,
                              :bp_category, :product_group ]
  end

  it 'should contain the correct model data' do
    @model.product_id.should == 1000
    @model.sales_channel.should == 'Brightpearl'
    @model.sku.should == ''
    @model.ean.should be_nil
  end
end
