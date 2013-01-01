require 'spec_helper'

describe Nacre::API::OrderSearch do
  let(:connection) { mock("connection") }
  let(:search_url) { 'order-service/order-search' }

  before do
    Nacre::API::OrderSearch.stub(:connection).and_return(connection)
  end

  context "when no search query is provided" do
    before do
      response = mock("response")
      response.stub(:body).and_return(response_json)
      connection.should_receive(:get).
        with(search_url + '?pageSize=200&firstResult=1').
        any_number_of_times.
        and_return(response)
    end

    describe "#results" do
      let(:response_json) { "{ foo : 'bar' }" }
      let(:returned_results) { mock("a result") }

      it "should return a search results object" do
        Nacre::API::OrderSearchResults.should_receive(:new_from_json).
          with(response_json).
          and_return(returned_results)

        results = Nacre::API::OrderSearch.new(search_url).results
        results.should == returned_results
      end
    end
  end


  describe "when search params are provided" do
    let(:param_list) {
      []
    }
  end
end
