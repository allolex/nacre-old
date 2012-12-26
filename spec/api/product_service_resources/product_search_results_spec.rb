require 'spec_helper'

describe Nacre::API::ProductSearchResults do
  context "when initialized with no data" do
    it "should be empty" do
      Nacre::API::ProductSearchResults.new.should be_empty
    end
  end

  context "when initialized from search result json" do
    context "when the json contains 0 results" do
      let(:response_json) { IO.read("spec/fixtures/json/product_search_result_empty.json") }

      it 'should return an empty ProductSearchResults' do
        search_results = Nacre::API::ProductSearchResults.new_from_json(response_json)
        search_results.should be_a(Nacre::API::ProductSearchResults)
        search_results.should be_empty
      end
    end

    context "when the json contains 1 or more results" do
      let(:response_json) { IO.read("spec/fixtures/json/product_search_result.json") }
      let(:results) { Nacre::API::ProductSearchResults.new_from_json(response_json) }

      it 'results items should be an array of OpenStructs' do
        results.should be_a(Nacre::API::ProductSearchResults)
        results.length.should == 7

        results.items.first.productId.should == 1000
        results.items.first.productName.should == "Misc item without VAT"
        results.items.first.SKU.should == ""
        results.items.first.EAN.should be_nil
        results.items.first.UPC.should be_nil
        results.items.first.ISBN.should be_nil
        results.items.first.stockTracked.should == false
        results.items.first.salesChannelName.should == "Brightpearl"
        results.items.first.createdOn.should == "2007-05-29T10:42:08.000Z"
        results.items.first.updatedOn.should ==  "2007-09-08T14:42:45.000Z"
        results.items.first.brightpearlCategoryCode.should == 1000
        results.items.first.productGroupId.should == 0
      end

      it "should have the correct metadata" do
        results.metadata.columns.length.should == 12
        results.metadata.firstResult.should == 1
        results.metadata.lastResult.should == 7
        results.metadata.resultsAvailable.should == 7
        results.metadata.resultsReturned.should == 7
      end

      it "should return the id set of the search results" do
        results.id_set.should =~ Array(1000..1006)
      end
    end
  end
end
