FactoryGirl.define do
  factory :template, class: Calligraph::Template do
	sequence(:title){|n| "Template #{n}" }
	markup <<-markup
	<img style="width:200px;height:200px;" class="admin-editable" data-src="img_src" data-alt="img_alt" data-title="img_title" title="{{img_title}}" alt="{{img_alt}}" src="{{img_src}}"/>

	<p class="admin-editable" data-field="content">{{content}}</p> 

	<a class="admin-editable" data-href="link_url" data-text="link_text" data-title="link_title" href="{{link_url}}" title="{{link_title}}">{{link_text}}</a> 

	<div class="admin-editable youtube-video"> 
	  <iframe style="margin-left:30px; width:590px; height:360px;" data-src="youtube_src" src="{{youtube_src}}" frameborder="0"></iframe> 
	  <i class="fa fa-cog change-youtube-video"></i> 
	</div>
	markup
  end
end
