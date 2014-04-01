require "mustache"
module Calligraph
  class Content < ActiveRecord::Base
    belongs_to :content_template, polymorphic: true
    
    validates :path, uniqueness: true, presence: true
    validates :data, presence: true
    validates :content_template, presence: true

    validate :data_format

    def markup(locale)
      data_json = JSON.parse(data)
      data_json = data_json[I18n.locale.to_s].nil? ? data_json : data_json[I18n.locale.to_s]
      Mustache.render(content_template.markup, data_json) #case when content is rendered based on html template and not rails action based
    end

    protected

    def data_format
      begin
        !!JSON.parse(data)
      rescue
        errors[:data] << "Invalid JSON"
        false
      end
    end
  end
end
