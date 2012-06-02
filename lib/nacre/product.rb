require 'nacre'

module Nacre

  class Product < Nacre::Service

    def initialize args
      p self.class
      p self.name
      super
    end
  end
end
