module Calligraph
  class MetaTag < ActiveRecord::Base
    validates :name, presence: true
    validates :value, presence: true
    validates :content, presence: true

    belongs_to :content, inverse_of: :meta_tags
  end
end