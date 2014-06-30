module Calligraph
  module FileHelper
    def stylesheet_exists? stylesheet_name
      partial_stylesheet_exists = File.file?(stylesheet_file("_#{stylesheet_name}.css")) || File.file?(stylesheet_file("_#{stylesheet_name}.scss")) || File.file?(stylesheet_file("_#{stylesheet_name}.css.scss"))
      partial_stylesheet_exists || File.file?(stylesheet_file("#{stylesheet_name}.css")) || File.file?(stylesheet_file("#{stylesheet_name}.scss")) || File.file?(stylesheet_file("#{stylesheet_name}.css.scss"))
    end

    private
    def stylesheet_file filename
      Rails.root.join('app','assets','stylesheets',filename)
    end
  end
end