require 'spec_helper'

describe Nacre::Connection do
    context "when valid params are provided" do
        before do
            connection = Nacre::Connection.new()
        end
        
        it "should be configured" do
            connection.should be_configured
        end

        it 'should authenticate to the Nacre web API' do
            # fe54961f-8adf-4d00-8bd3-185a479e827a
            @bp.token.is_valid?.should be_true
        end

        it 'should insert the token into the config request header' do
            @bp.config.header['brightpearl-auth'].should == @bp.token.to_s
        end

    end

    context "when invalid params are provided" do
        it "should not be configured" do
            connection = Nacre::Connection.new()
            connection.should_not be_configured
        end
    end
end
