require 'spec_helper'

describe Nacre do

  before :all do
    @config = 'config/test_config.yml'
    @bp = Nacre::Api.new( config: @config )
  end

  it 'should have a configuration file' do
    File.exists?(@config).should == true
  end

  it 'can be instantiated' do
    @bp.should be_a(Nacre::Api)
  end

  it 'should read in the credentials from a file' do
    @bp.email.should == 'damon@allolex.net'
    @bp.id.should == 'allolex'
    @bp.distribution_centre.should == 'eu1'
    @bp.api_version.should == '2.0.0'
  end

  it 'should not output the password' do
    expect {@bp.password}.to raise_error(NoMethodError)
  end

  it 'should authenticate to the Nacre web API' do
    # fe54961f-8adf-4d00-8bd3-185a479e827a
    @bp.auth_token.to_s.should match(/^[a-z0-9]{8}-(?:[a-z0-9]{4}-){3}[a-z0-9]{12}$/)
  end
end
