source "https://rubygems.org"

# Declare your gem's dependencies in calligraph.gemspec.
gemspec

gem 'activeadmin', git: 'https://github.com/gregbell/active_admin.git', branch: 'master'
gem 'devise'

group :test do
  gem 'simplecov', :require => false
  gem 'factory_girl_rails'
  gem 'database_cleaner'
end

group :development do
  gem 'unicorn'
end