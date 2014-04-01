$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "calligraph/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "calligraph"
  s.version     = Calligraph::VERSION
  s.authors     = ["Srikanth", "Praveen"]
  s.email       = ["srikanth.ddit@gmail.com"]
  s.homepage    = "http://sriv.github.com/calligraph"
  s.summary     = "Calligraph Content Management System"
  s.description = "Calligraph is a simple Content Management System, built on top of ActiveAdmin and Mustache.rb."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.0"
  s.add_dependency 'mustache', '0.99.5'
  
  s.add_development_dependency "sqlite3"
end
