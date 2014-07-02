module Calligraph
  module ContentHelper
    def generate_hash string
      Digest::SHA1.hexdigest("#{string}#{SECRET_KEY}")
    end

    def is_token_valid? string, token
      generate_hash(string) == token
    end
  end
end
