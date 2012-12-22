require 'spec_helper'

describe Nacre::Config do
  context 'a good configuration file' do
    before :all do
      @file = 'spec/fixtures/test_config.yml'
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
      @file = 'spec/fixtures/test_bad_config.yml'
      expect { Nacre::Config.new(file: @file)
      }.to raise_error "password required"
    end
  end

  context 'a nonexistent configuration file' do
    it 'should raise an error' do
      @file = 'spec/fixtures/nonexistent_config.yml'
      expect { Nacre::Config.new(file: @file)
      }.to raise_error "File not found"
    end
  end

  pending 'no configuration file is provided' do
  end
  

  context "url generation" do
      let(:filename) { 'spec/fixtures/test_config.yml' }

      context "without overriding the base url" do
          before do
              @cfg = Nacre::Config.new(file: filename)
          end

          it "constructs the api URL from the config" do
              @cfg.api_url.should == URI.parse("https://ws-eu1.brightpearl.com/2.0.0/your_brightpearl_id")
          end

          it "constructs the auth URL from the config" do
              @cfg.auth_url.should == URI.parse("https://ws-eu1.brightpearl.com/your_brightpearl_id/authorise")
          end
      end

      context "if base url is provided to config" do
          it "constructs the api URL using the override base url" do
              cfg = Nacre::Config.new(file: filename, 
                                      base_url: "http://example.com")
              cfg.api_url.should == URI.parse("http://example.com/2.0.0/your_brightpearl_id")
          end
      end
  end
end
