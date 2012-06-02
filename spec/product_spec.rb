require 'spec_helper'

describe Nacre::Product do

  before :all do
    @config = 'config/test_config.yml'
    @bp = Nacre::Api.new( config: @config )
    @prod = @bp.product
  end

  it 'can be instantiated' do
    @prod.should be_a(Nacre::Product)
  end
end
