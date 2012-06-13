require 'spec_helper'

describe Nacre do

  before :all do
    @config = 'config/test_config.yml'
    @bp = Nacre::Api.new( file: @config )
  end

  it 'can be instantiated' do
    @bp.should be_a(Nacre::Api)
  end

  it 'should authenticate to the Nacre web API' do
    # fe54961f-8adf-4d00-8bd3-185a479e827a
    @bp.token.is_valid?.should be_true
  end
end
