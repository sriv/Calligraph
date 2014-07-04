ActiveAdmin.register Calligraph::Template, as: "Template" do
  permit_params :title, :markup
  config.comments = false
  
  index do
    column :title
    column :created_at
    actions
  end

  filter :title

  form do |f|
    f.inputs "Template Details" do
      f.input :title
      f.input :markup
    end
    f.actions
  end
end
