FactoryGirl.define do
  factory :action_content, class: Calligraph::ActionContent do
    sequence(:title){|n| "Action Content #{n}" }
    sequence(:controller){|n| "Controller #{n}" }
    sequence(:action){|n| "Action #{n}" }
  end
end
