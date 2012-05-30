#!/usr/bin/env ruby

require 'json'
require 'rest_client'

cred_file = File.join(File.dirname(__FILE__),'../credentials/test')

@credentials = []

def load_creds cred_file
  fail "Credentials file missing at #{cred_file}" unless File.exists?(cred_file)
  @credentials = File.open(cred_file,'r').readlines.each.map(&:chomp)
  if @credentials.length == 3
    return true
  else
    return false
  end
end

if load_creds cred_file
  # The Brightperl data centre code. See
  #   http://www.brightpearl.com/developer/latest/concept/uri-syntax.html
  dc_code = 'eu1'
  account_id = @credentials[0]

  uri = URI.parse( "https://ws-%s.brightpearl.com/%s/authorise" % [dc_code, account_id] )

  message = {
    apiAccountCredentials: {
          emailAddress: @credentials[1],
          password:     @credentials[2]
    }
  }.to_json

  response = RestClient.post uri.to_s, message, :content_type => :json, :accept => :json

  p response.to_s
else
  fail "Invalid credentials file #{cred_file}"
end
