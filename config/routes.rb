Calligraph::Engine.routes.draw do
	  get 'content_templates' => 'content#fetch_templates', as: "content_templates"
end
