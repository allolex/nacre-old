require 'spec_helper'

describe Nacre::API::Order do
  let(:connection) { double("connection") }

  before do
    Nacre::API::Order.stub(:connection).and_return(connection)
  end

  context "when instantiated with no data" do
    let(:model) {
      Nacre::API::Order.new
    }

    it 'should create an instance' do
      model.should be_a(Nacre::API::Order)
    end
  end

  context "when instantiated with valid data" do
    let(:valid_params) {}

    let(:model) {
      Nacre::API::Order.new(valid_params)
    }

    describe "initialization" do
      it 'should create an instance' do
        model.should be_a(Nacre::API::Order)
      end

      it 'should have a list of fields' do
        model.class.fields.should == [
          :id, :parent_order_id, :order_type_code,
          :reference, :acknowledged, :order_status,
          :stock_status_code, :allocation_status_code,
          :placed_on, :created_on, :created_by_id,
          :price_list_id, :price_mode_code, :delivery,
          :invoices, :currency, :total_value,
          :assignment, :parties, :order_rows
        ]
      end

      pending 'should contain the correct model data' do
        model.id.should == 1
        model.order_type_code.should == ''
      end
    end

    describe "find" do
      before do
        response = double("response")
        response.stub(:body).and_return(response_json)
        connection.stub(:get).
          and_return(response)
        connection.should_receive(:get).
          with("/order-service/order/123456")
      end

      context "when an empty list comes back" do
        let(:response_json) { { "response" => [] }.to_json }

        it 'should return nil' do
          Nacre::API::Order.find(123456).should be_nil
        end
      end

      context "when one valid value comes back" do
        let(:results) { [] }
        let(:response_json) { IO.read("spec/fixtures/json/order.json") }

        it 'should return a valid Order' do
          order = Nacre::API::Order.find(123456)
          order.should be_a(Nacre::API::Order)
          order.id.should == 123456
          order.reference.should == 'order#001'
          order.currency.accounting_currency_code.should == 'GBP'
        end
      end
    end

    describe "all" do
      context "when an empty list comes back" do
        it 'should return an empty array' do
          Nacre::API::OrderSearch.any_instance.should_receive(:results).and_return(Nacre::API::OrderSearchResults.new)
          all_orders = Nacre::API::Order.all
          all_orders.should be_a(Array)
          all_orders.should be_empty
        end
      end

      context "when a list with actual values comes back" do
        let(:response_json) { IO.read("spec/fixtures/json/order.json") }

        it 'should return an array of Orders' do
          search_results = Nacre::API::OrderSearchResults.new_from_json(
              IO.read("spec/fixtures/json/order_search_result.json")
          )
          Nacre::API::OrderSearch.any_instance.should_receive(:results).and_return(search_results)

          response = double("response")
          response.stub(:body).and_return(response_json)
          connection.should_receive(:get).
            with("/order-service/order/123456,123457,123458").
            and_return(response)

          orders = Nacre::API::Order.all
          orders.should be_a(Array)
          orders.length.should == 1

          order = orders.first
          order.should be_a(Nacre::API::Order)
          order.id.should == 123456
          order.reference.should == 'order#001'
          order.currency.accounting_currency_code.should == 'GBP'
        end
      end
    end

    describe "save"

    describe "delete"
  end
end
