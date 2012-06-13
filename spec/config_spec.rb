require 'spec_helper'

describe Nacre::Config do

  before :all do
    @file = 'config/test_config.yml'
    @cfg = Nacre::Config.new( file: @file )
  end

  it 'should have a configuration file' do
    File.exists?(@file).should be_true
  end

  it 'can be instantiated' do
    @cfg.should be_a(Nacre::Config)
  end

  it 'should read in the credentials from a file' do
    @cfg.email.should == 'damon@allolex.net'
    @cfg.id.should == 'allolex'
    @cfg.distribution_centre.should == 'eu1'
    @cfg.api_version.should == '2.0.0'
  end
end

