require 'spec_helper'

describe Nacre::Config do

  describe 'should' do

    before :all do
      @file = 'config/test_config.yml'
      @cfg = Nacre::Config.new( file: @file )
    end

    it 'have a configuration file' do
      File.exists?(@file).should be_true
    end

    it 'allow generation of an instance' do
      @cfg.should be_a(Nacre::Config)
    end

    it 'read in the credentials from a file' do
      @cfg.email.should == 'damon@allolex.net'
      @cfg.id.should == 'allolex'
      @cfg.distribution_centre.should == 'eu1'
      @cfg.api_version.should == '2.0.0'
    end
  end


  describe 'should raise an error' do

    it 'if required arguments are missing' do
      @file = 'spec/fixtures/test_bad_config.yml'
      expect { Nacre::Config.new( file: @file )
        }.to raise_error
    end

  end
end

