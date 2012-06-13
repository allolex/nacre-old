require 'nacre'

module Nacre

  class Token

    attr_reader :token

    def initialize token
      if validate token
        @token = token
      else
        fail TokenError
      end
      self
    end

    def to_s
      @token.to_s
    end

    def is_valid?
      validate @token
    end

  private

    def validate text
      if text =~ /^[a-z0-9]{8}-(?:[a-z0-9]{4}-){3}[a-z0-9]{12}$/i
        return true
      else
        return false
      end
    end
  end

  class TokenError < StandardError

  end
end
