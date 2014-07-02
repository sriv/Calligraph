FactoryGirl.define do
  factory :meta_tag, class: Calligraph::MetaTag do
    sequence(:name) {|n| "Tag#{n}"}
    sequence(:value) {|n| "Value#{n}"}
  end
end