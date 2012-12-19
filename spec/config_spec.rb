require 'spec_helper'

describe Nacre::Config do
  context 'a good configuration file' do
    before :all do
      @file = 'fixtures/test_config.yml'
      @cfg = Nacre::Config.new(file: @file)
    end

    it 'have a configuration file' do
      File.exists?(@file).should be_true
    end

    it 'allow generation of an instance' do
      @cfg.should be_a(Nacre::Config)
    end

    it 'read in the credentials from a file' do
      @cfg.email.should == 'your_brightpearl_user_email'
      @cfg.id.should == 'your_brightpearl_id'
      @cfg.distribution_centre.should == 'eu1'
      @cfg.api_version.should == '2.0.0'
    end
  end

  context 'a configuration file with missing fields' do
    it 'should raise an error' do
      @file = 'fixtures/test_bad_config.yml'
      expect { Nacre::Config.new(file: @file)
      }.to raise_error "password required"
    end
  end

  context 'a nonexistent configuration file' do
    it 'should raise an error' do
      @file = 'fixtures/nonexistent_config.yml'
      expect { Nacre::Config.new(file: @file)
      }.to raise_error "File not found"
    end
  end
end
