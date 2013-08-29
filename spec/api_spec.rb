require 'spec_helper'

describe Nacre do
    let(:connection) { double("nacre connection") }

    before do
        @config = 'spec/fixtures/test_config.yml'
        connection.stub(:authenticate)
        Nacre::Connection.stub(:new).and_return(connection)
    end

    describe "initializing" do
        it 'can be instantiated' do
            bp = Nacre::Api.new( file: @config )
            bp.should be_a(Nacre::Api)
        end

        it 'sets its config' do
            bp = Nacre::Api.new( file: @config )

            bp.config.file.should == 'spec/fixtures/test_config.yml'
            bp.config.email.should == 'your_brightpearl_user_email'
            bp.config.password.should == 'your_brightpearl_password'
            bp.config.distribution_centre.should == 'eu1'
            bp.config.api_version.should == '2.0.0'
        end

        it 'creates and calls connect on a Nacre::Connection' do
            connection = double("connection")
            auth_data = double("auth data")
            auth_url = double("auth url")
            api_url = double("api url")

            Nacre::Api.any_instance.should_receive(:auth_data).and_return auth_data
            Nacre::Config.any_instance.should_receive(:auth_url).and_return auth_url
            Nacre::Config.any_instance.should_receive(:api_url).and_return api_url

            connection_params = {
                auth_data: auth_data,
                auth_url: auth_url,
                api_url: api_url
            }

            Nacre::Connection.should_receive(:new).with(connection_params).and_return(connection)

            connection.should_receive :authenticate

            bp = Nacre::Api.new( file: @config )
        end
    end

    describe "#auth_data" do
        context "if config is valid" do
            it "generates auth data json from username and password" do
                bp = Nacre::Api.new( file: @config )

                bp.send(:auth_data).should == {
                    apiAccountCredentials: {
                        emailAddress: 'your_brightpearl_user_email',
                        password: 'your_brightpearl_password'
                    }
                }
            end
        end

        context "if config is not valid" do
            pending "should return nil"
        end
    end
end
