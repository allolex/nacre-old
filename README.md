[![Build Status](https://travis-ci.org/allolex/nacre.png?branch=master)](https://travis-ci.org/allolex/nacre) [![Code Climate](https://codeclimate.com/github/allolex/nacre.png)](https://codeclimate.com/github/allolex/nacre) [![Coverage Status](https://coveralls.io/repos/allolex/nacre/badge.png?branch=master)](https://coveralls.io/r/allolex/nacre?branch=master)

THIS LIBRARY HAS BEEN / IS BEING REPLACED BY https://github.com/allolex/nacre 

If you'd like to contribute, then it would be good to do it on the newer library, which will be nicer to code. Features include better support for authentication errors, neater code re-use (mixins FTW) and just generally a more robust approach.


# Nacre

Nacre is a Ruby gem that wraps the API of the Brightpearl accounting software service.

http://www.brightpearl.com/developer/latest/

## Installation

Add this line to your application's Gemfile:

```ruby
gem "nacre", :git => "git://github.com/allolex/nacre.git"
```

And then execute:

```
$ bundle
```

## Usage

```ruby
require 'nacre'
api = Nacre::Api.new( file: 'config/test_config.yml' )
products_list = Nacre::API::Product.all
product = Nacre::API::Product.find(1000)
```

Make sure you copy the sample config file to `test_config.yml` with your credentials.

## Features

- Configuration support. See config/ for a sample YAML file.
- API authentication

These are functional, but definitely need some work:

- Product
- Order


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
