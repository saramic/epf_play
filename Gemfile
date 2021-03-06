source 'https://rubygems.org'

# Core
gem 'rails', '3.2.13'
gem "unicorn", ">= 4.3.1", :group => :production
gem "pg", ">= 0.15.0"
gem 'jquery-rails'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

# Authentication/Authorization
gem "devise", ">= 2.2.3"
gem "cancan", ">= 1.6.9"
gem "rolify", ">= 3.2.0"

# presentation
gem "haml-rails", ">= 0.4"
gem "html2haml", ">= 1.0.1", :group => :development
gem "bootstrap-sass", ">= 2.3.0.0"
gem 'twitter_bootstrap_form_for'

# File uploads
gem 'carrierwave'
gem 'fog'

# development and test
gem "rspec-rails", ">= 2.12.2", :group => [:development, :test]
gem "database_cleaner", ">= 1.0.0.RC1", :group => :test
gem "email_spec", ">= 1.4.0", :group => :test
gem "cucumber-rails", ">= 1.3.1", :group => :test, :require => false
gem "launchy", ">= 2.2.0", :group => :test
gem "capybara", ">= 2.0.3", :group => :test
gem "factory_girl_rails", ">= 4.2.0", :group => [:development, :test]
gem "quiet_assets", ">= 1.0.2", :group => :development
gem "better_errors", ">= 0.7.2", :group => :development
gem "binding_of_caller", ">= 0.7.1", :group => :development, :platforms => [:mri_19, :rbx]
gem "hub", ">= 1.10.2", :require => nil, :group => [:development]
group :development do
  gem 'selenium-webdriver'
  gem 'fakeweb'
end
