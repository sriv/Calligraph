module Calligraph
  class ContentController < ApplicationController
    include UrlHelper
    include FileHelper
    include ContentHelper

    def show
      path = params[:path]
      content = Content.find_by(path: "/#{path}")
      if content.nil? || (params[:token].present? && !is_token_valid?(content.path, params[:token]))
        error_404
      else
        if stale?(last_modified: content.updated_at)
          if content.content_template.class.name == "Calligraph::Template"
            template_stylesheet = content.content_template.title.gsub(/ /,'').underscore
            stylesheet_tag = stylesheet_exists?(template_stylesheet) ? "<%= stylesheet_link_tag \"#{template_stylesheet}\", media: \"all\" %>" : ""
            javascript_tag = "<%= javascript_include_tag \"calligraph/inline_editor\", \"calligraph/picoModal\" %>"
            content_html = "#{javascript_tag}#{stylesheet_tag}#{content.markup(I18n.locale)}"
            render inline: content_html, layout: "layouts/application", content_type: "text/html; charset=utf-8"
          else
            render nothing: true
          end
        end
      end
    end

    def fetch_templates
      template_type = params[:template_type]
      template_class = template_type.constantize
      render json: template_class.select(:id, :title)
    end
  end
end
