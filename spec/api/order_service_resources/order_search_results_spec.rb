require 'spec_helper'

describe Nacre::API::OrderSearchResults do
  context "when initialized with no data" do
    it "should be empty" do
      Nacre::API::OrderSearchResults.new.should be_empty
    end
  end

  context "when initialized from search result json" do
    context "when the json contains 0 results" do
      let(:response_json) { IO.read("spec/fixtures/json/order_search_result_empty.json") }

      it 'should return an empty OrderSearchResults' do
        search_results = Nacre::API::OrderSearchResults.new_from_json(response_json)
        search_results.should be_a(Nacre::API::OrderSearchResults)
        search_results.should be_empty
      end
    end

    context "when the json contains 1 or more results" do
      let(:response_json) { IO.read("spec/fixtures/json/order_search_result.json") }
      let(:results) { Nacre::API::OrderSearchResults.new_from_json(response_json) }

      it 'results items should be an array of OpenStructs' do
        results.should be_a(Nacre::API::OrderSearchResults)
        results.length.should == 3

        results.items.first.orderId.should            == 123456
        results.items.first.orderTypeId.should        == 1
        results.items.first.contactId.should          == 253
        results.items.first.orderStatusId.should      == 4
        results.items.first.orderStockStatusId.should == 3
        results.items.first.createdOn.should          == '2012-12-13T13:00:42.000Z'
        results.items.first.createdById               == '280'
      end

      it "should have the correct metadata" do
        results.metadata.columns.length.should   == 7
        results.metadata.firstResult.should      == 1
        results.metadata.lastResult.should       == 3
        results.metadata.resultsAvailable.should == 3
        results.metadata.resultsReturned.should  == 3
      end

      it "should return the id set of the search results" do
        results.id_set.should =~ [123456,123457,123458]
      end
    end
  end
end
