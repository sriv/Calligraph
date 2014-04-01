module Calligraph
  class Template < ActiveRecord::Base
    has_many :content, as: :content_template
  end
end
