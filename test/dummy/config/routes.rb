Rails.application.routes.draw do

  mount Calligraph::Engine => "/"

  devise_for :calligraph_admin_users, {
    class_name: "Calligraph::AdminUser",
    path_names: {sign_in: "login", sign_out: "logout"},
    path: "/admin",
    module: :devise
  }

  ActiveAdmin.routes(self)
  get "/*path" => "calligraph/content#show", as: 'static_content'
end
