require 'spec_helper'

describe Nacre::API::Product do
  let(:connection) { mock("connection") }

  before do
    Nacre::API::Product.stub(:connection).and_return(connection)
  end

  context "when instantiated with no data" do
    let(:model) {
      Nacre::API::Product.new
    }

    it 'should create an instance' do
      model.should be_a(Nacre::API::Product)
    end
  end

  context "when instantiated with valid data" do
    let(:param_list) {
      [ 1000, "Misc item without VAT", "", nil, nil, nil, false,
              "Brightpearl", "2007-05-29T10:42:08.000+01:00",
              "2007-09-08T14:42:45.000+01:00", "276", 0 ]
    }

    let(:model) {
      Nacre::API::Product.new(param_list)
    }

    describe "initialization" do
      it 'should create an instance' do
        model.should be_a(Nacre::API::Product)
      end

      it 'should have a list of fields' do
        model.fields.should == [ :product_id, :product_name, :sku, :ean, :upc, :isbn,
          :stock_tracked, :sales_channel, :created, :updated,
          :bp_category, :product_group ]
      end

      it 'should contain the correct model data' do
        model.product_id.should == 1000
        model.sales_channel.should == 'Brightpearl'
        model.sku.should == ''
        model.ean.should be_nil
      end
    end

    describe "all" do
      let(:list_json) { { "response" => results }.to_json }

      before do
        response = mock("response")
        response.stub(:body).and_return(list_json)
        connection.should_receive(:get).
          with("/product-service/product-search").
          any_number_of_times.
          and_return(response)
      end

      context "when an empty list comes back" do
        let(:results) { [] }
        
        it 'should return an empty array' do
          Nacre::API::Product.all.should be_a(Array)
          Nacre::API::Product.all.should be_empty
        end
      end

      pending "when a list with actual values comes back" do
        let(:results) { [] }

        it 'should return an array of Products' do
          Nacre::API::Product.all.should be_a(Array)
          Nacre::API::Product.all.length.should == 2
          Nacre::API::Product.all.first.should be_a(Nacre::API::Product)
        end
      end
    end
  end
end
