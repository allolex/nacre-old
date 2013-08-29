require 'spec_helper'

describe Nacre::API::Product do
  let(:connection) { double("connection") }

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
    let(:valid_params) {}

    let(:model) {
      Nacre::API::Product.new(valid_params)
    }

    describe "initialization" do
      it 'should create an instance' do
        model.should be_a(Nacre::API::Product)
      end

      it 'should have a list of fields' do
        model.class.fields.should == [
          :id, :brand_id, :product_type_id, :identity,
          :product_group_id, :stock, :financial_details,
          :sales_channels, :composition, :variations
        ]
      end

      pending 'should contain the correct model data' do
        model.product_id.should == 1000
        model.sales_channel.should == 'Brightpearl'
        model.sku.should == ''
        model.ean.should be_nil
      end
    end

    describe "find" do
      before do
        response = double("response")
        response.stub(:body).and_return(response_json)
        connection.stub(:get).
          and_return(response)
        connection.should_receive(:get).
          with("/product-service/product/1008")
      end

      context "when an empty list comes back" do
        let(:response_json) { { "response" => [] }.to_json }

        it 'should return nil' do
          Nacre::API::Product.find(1008).should be_nil
        end
      end

      context "when one valid value comes back" do
        let(:results) { [] }
        let(:response_json) { IO.read("spec/fixtures/json/product.json") }

        it 'should return a valid Product' do
          product = Nacre::API::Product.find(1008)
          product.should be_a(Nacre::API::Product)
          product.id.should == 1008
          product.identity.sku.should == "SKU0001"
        end

        it 'should convert camel case fields to snake case methods' do
          product = Nacre::API::Product.find(1008)
          product.product_type_id.should == 1
          product.financial_details.tax_code.id.should == 7
        end
      end
    end

    describe "all" do
      context "when an empty list comes back" do
        it 'should return an empty array' do
          Nacre::API::ProductSearch.any_instance.should_receive(:results).and_return(Nacre::API::ProductSearchResults.new)
          all_products = Nacre::API::Product.all
          all_products.should be_a(Array)
          all_products.should be_empty
        end
      end

      context "when a list with actual values comes back" do
        let(:response_json) { IO.read("spec/fixtures/json/product.json") }

        it 'should return an array of Products' do
          search_results = Nacre::API::ProductSearchResults.new_from_json(
              IO.read("spec/fixtures/json/product_search_result.json")
          )
          Nacre::API::ProductSearch.any_instance.should_receive(:results).and_return(search_results)

          response = double("response")
          response.stub(:body).and_return(response_json)
          connection.should_receive(:get).
            with("/product-service/product/1000,1001,1002,1003,1004,1005,1006").
            and_return(response)

          products = Nacre::API::Product.all
          products.should be_a(Array)
          products.length.should == 1

          product = products.first
          product.should be_a(Nacre::API::Product)
          product.id.should == 1008
          product.identity.sku.should == "SKU0001"
          product.product_type_id.should == 1
        end
      end
    end

    describe "save"

    describe "delete"
  end
end
