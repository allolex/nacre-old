# Allows easy conversion of hashes into openstructs

require "ostruct"
require 'active_support/inflector'

class Object

  def to_openstruct
    self
  end
end


class Array

  def to_openstruct
    map{ |el| el.to_openstruct }
  end
end


class Hash

  def to_openstruct
    mapped = {}
    each{ |key,value| mapped[key.to_s.underscore] = value.to_openstruct }
    OpenStruct.new(mapped)
  end
end
