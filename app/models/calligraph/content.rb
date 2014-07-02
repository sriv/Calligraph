require 'mustache'
module Calligraph
  class Content < ActiveRecord::Base
    belongs_to :content_template, polymorphic: true
    
    validates :path, uniqueness: true, presence: true
    validates :data, presence: true
    validates :content_template, presence: true

    validate :data_format

    has_many :meta_tags, dependent: :destroy, inverse_of: :content

    accepts_nested_attributes_for :meta_tags, allow_destroy: true

    def markup(locale)
      data_json = JSON.parse(data)
      data_json = data_json[I18n.locale.to_s].nil? ? data_json : data_json[I18n.locale.to_s]
      Mustache.render(content_template.markup, data_json)
    end

    def meta_tags_hash
      tags = {}
      meta_tags.to_a.each do |meta_tag|
        tags = tags.merge({"#{meta_tag.name}" => "#{meta_tag.value}"})
      end
      tags
    end

    protected

    def data_format
      begin
        !!JSON.parse(data)
      rescue
        errors[:data] << 'Invalid JSON'
        false
      end
    end
  end
end
