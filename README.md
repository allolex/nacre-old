# Nacre

Nacre is a Ruby wrapper around the Brightpearl accounting software service. It
uses the Brightpearl API.

http://www.brightpearl.com/developer/latest/

## Installation

Add this line to your application's Gemfile:

    gem "nacre", :git => "git://github.com/allolex/nacre.git"

And then execute:

    $ bundle

## Usage

This gem isn't really very functional as of yet, so for now you can look
at the tests to see how it's used.

Make sure you copy the sample config file to `test_config.yml` with your credentials.

## Features

- Configuration support. See config/ for a sample YAML file.
- API authentication

These are functional, but definitely need some work:

- Product
- Order

## Synopsis

    require 'nacre'

    api = Nacre::Api.new( file: 'config/test_southern.yml' )

    products_list = Nacre::API::Product.all

    product = Nacre::API::Product.find(1000)

## Todo

- Services
  - Accounting
  - Contact
  - Warehouse

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Thanks 

Many thanks go to Angela Heenan at and Helen Bowling at Brightpearl.

Alex Stupakov, you're an absolute ace for helping to unstick this project.
