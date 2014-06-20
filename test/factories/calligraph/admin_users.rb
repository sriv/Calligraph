# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin_user, class: Calligraph::AdminUser do
	sequence(:email) {|n| "admin#{n}@calligraph.com"}
	password "password"
	password_confirmation "password"
	role "superadmin"
  end
end
