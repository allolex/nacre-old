require 'spec_helper'

describe Nacre::Connection do
    context "when valid params are provided" do
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

        describe "#initialize" do
            it "should set headers on the Faraday connection" do
                connection.connection.headers['Content-Type'].should == "application/json"
            end

            it "should not be authenticated" do
                connection.connection.headers['brightpearl-auth'].should be_nil
            end

            #it 'should authenticate to the Nacre web API' do
            ## fe54961f-8adf-4d00-8bd3-185a479e827a
            #@bp.token.is_valid?.should be_true
            #end

            #it 'should insert the token into the config request header' do
            #@bp.config.header['brightpearl-auth'].should == @bp.token.to_s
            #end
        end

        describe "authentication" do
            it "should send the correct authentication request to brightpearl" do
                connection.connection.should_receive(:post).with(
                    auth_url, auth_data.to_json, { 
                        'Content-Type' => 'application/json', 
                        'Accept' => 'json' 
                    })
                    
                connection.authenticate
            end

            context "when brightpearl responds with a valid token" do
                it "should set the token"
            end
            
            context "when brightpearl responds without a valid token" do
                it "should throw an exception"
            end
        end

        context "when invalid params are provided" do
            it "should not be configured" do
                connection = Nacre::Connection.new()
                connection.should_not be_configured
            end
        end
    end


    describe "authenticated?" do
    end
end
