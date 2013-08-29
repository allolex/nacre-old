require 'spec_helper'

describe Nacre::API::ProductSearch do
  let(:connection) { double("connection") }
  let(:search_url) { 'product-service/product-search' }

  before do
    Nacre::API::ProductSearch.stub(:connection).and_return(connection)
  end

  context "when no search query is provided" do
    before do
      response = double("response")
      response.stub(:body).and_return(response_json)
      connection.stub(:get).
        and_return(response)
    end

    describe "#results" do
      let(:response_json) { "{ foo : 'bar' }" }
      let(:returned_results) { double("a result") }

      it "should return a search results object" do
        Nacre::API::ProductSearchResults.should_receive(:new_from_json).
          with(response_json).
          and_return(returned_results)

        results = Nacre::API::ProductSearch.new(search_url).results
        results.should == returned_results
      end
    end
  end


  describe "when search params are provided" do
    let(:param_list) {
      [ 1000, "Misc item without VAT", "", nil, nil, nil, false,
              "Brightpearl", "2007-05-29T10:42:08.000+01:00",
              "2007-09-08T14:42:45.000+01:00", "276", 0 ]
    }
  end
end
