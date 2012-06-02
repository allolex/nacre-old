require 'spec_helper'

describe Nacre::Token do

  before :all do
    @token_string = 'fe54961f-8adf-4d00-8bd3-185a479e827a'
    @tk = Nacre::Token.new(@token_string)
  end

  it 'should instantiate with a good token' do
    @tk.should be_a(Nacre::Token)
  end

  it 'should fail with a bad token' do
    expect { Nacre::Token.new('404') }.to raise_error(Nacre::TokenError)
  end

  it 'should have a working is_valid? method' do
    @tk.is_valid?.should == true
  end

  it 'should have a working to_s method' do
    @tk.to_s.should == @token_string
  end
end
