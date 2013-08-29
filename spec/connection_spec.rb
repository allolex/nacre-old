require 'spec_helper'

describe Nacre::Connection do
  let(:auth_url) { "auth_url" }
  let(:api_url) { "api_url" }
  let(:auth_data) {{
    "apiAccountCredentials" => {
      "emailAddress" => 'your_brightpearl_user_email',
      "password" => 'your_brightpearl_password'
    }
  }}

  let(:valid_params) {{
    auth_url: auth_url,
    api_url: api_url,
    auth_data: auth_data
  }}

  let(:connection) { Nacre::Connection.new(valid_params) }

  it "should initialize" do
    connection.should be_a Nacre::Connection
  end

  describe "authentication" do
    context "when brightpearl responds with a valid token" do
      let(:token_string) { "fe54961f-8adf-4d00-8bd3-185a479e827a" }
      let(:response_body) { {
        response: token_string
      }.to_json }

      before do
        connection_mock = double("connection").as_null_object
        Faraday.should_receive(:new).and_return(connection_mock)

        response = double("response")
        response.should_receive("body").and_return(response_body)

        connection_mock.should_receive(:post).
          with(auth_url, auth_data.to_json).
            and_return(response)

        connection.authenticate
      end

      it "should set the token" do
        connection.send(:token).should == token_string
      end

      pending "should set headers on the Faraday connection" do
        connection.connection.headers['brightpearl-auth'].should == token_string
        connection.connection.headers['Content-Type'].should == "application/json"
        connection.connection.headers['Accept'].should == "application/json"
      end
    end

    context "when brightpearl responds with an invalid token" do
      it "should throw an exception"
    end

    context "when brightpearl responds without a valid token" do
      it "should throw an exception"
    end
  end

  describe "get" do

    let(:connection) { Nacre::Connection.new(valid_params) }

    context "when there is a valid token" do

      it "sends a get request via Faraday" do
        faraday_connection = double("faraday connection")
        connection.stub(:connection).and_return(faraday_connection)

        faraday_connection.should_receive(:get).
          with("api_url/foo/bar")

        connection.get("foo/bar")
      end
    end
  end

  describe "authenticated?" do

  end
end
