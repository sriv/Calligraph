ActiveAdmin.register Calligraph::Content, as: "Content" do
  permit_params :title, :data, :path, :content_template_type, :content_template_id
  config.comments = false
  actions :all

  index do
    column :title
    column :created_at
    column :path
    default_actions
  end

  form do |f|
    f.inputs "Content Details" do
      f.input :title
      f.input :data
      f.input :path
      f.input :content_template_type, as: :select, collection: [["Template","Calligraph::Template"], ["Action","Calligraph::ActionContent"]], input_html: {data: {url: Calligraph::Engine.routes.url_helpers.content_templates_path}}
      f.input :content_template_id, as: :hidden, input_html: {id: "content_template_id", name: "content_template_id"}
      f.input :content_template_id, as: :select, collection: []
    end
    f.actions
  end

  show do
    path = "#{resource.path}?token=#{generate_hash(resource.path)}"
    render inline: "<iframe src=\"<%= path %>\" id='content_preview'></iframe>", locals: {path: path}
  end

  filter :title

  sidebar :data, :only => :show do
    render :partial => "admin/edit_page_data", :locals => { :resource => resource }
  end
end
