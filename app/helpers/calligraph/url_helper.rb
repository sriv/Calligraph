module Calligraph
  module UrlHelper
    def error_404
      render file: "#{::Rails.root}/public/404.html", status: 404
    end
  end
end