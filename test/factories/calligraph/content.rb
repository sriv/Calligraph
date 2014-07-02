FactoryGirl.define do
  factory :content, class: Calligraph::Content do
    sequence(:title){|n| "Page #{n}" }
    data <<-data
     {
       "img_src":"http://agentur-swissweb.com/files/sw/img/uploads/placeholder.png",
       "img_alt":"some alt text",
       "img_title":"some image title",
       "content":"Test Content",
       "link_url":"http://www.yahoo.com",
       "link_title":"safjaslkfasdlf hjasdl;f",
       "link_text":"Sign up!",
       "youtube_src":"https://www.youtube.com/embed/EdY_M-rKjKw?rel=0&amp;showinfo=0"
     }
    data
    content_template_id { association(:template).id }
    content_template_type "Calligraph::Template"
    meta_tags_attributes { [{name: 'og:title', value: 'Title'}, {name: 'og:url', value: 'www.example.com'}] }
  end
end
