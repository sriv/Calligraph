module Calligraph
  module ContentHelper
    def generate_hash string
      Digest::SHA1.hexdigest("#{string}#{SECRET_KEY}")
    end

    def compare_to_hash string, token
      Digest::SHA1.hexdigest("#{string}#{SECRET_KEY}") == token
    end
  end
end
