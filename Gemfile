source 'https://rubygems.org'

gem 'rails', '3.2.6'
gem 'feedzirra'
#gem 'mongoid', '~> 3.0.2'
gem "mongoid", "2.0.1"
gem 'cancan'

gem 'therubyracer'
gem "less-rails" #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
gem "twitter-bootstrap-rails"

group :development do
	gem 'sqlite3'
end
group :production do 
  gem 'sqlite3'
end
group :staging do
	gem 'pg'
	#gem 'thin'
end

gem 'heroku'
gem 'bson_ext'

gem 'bcrypt-ruby', :require => 'bcrypt'
# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby
  gem 'uglifier', '>= 1.0.3'
  gem 'twitter-bootstrap-rails'
  gem 'jquery-fileupload-rails'  
end

gem 'jquery-rails'

gem 'rspec-rails', :group => [:development, :test]
group :test do 
  gem 'database_cleaner'
  gem 'capybara', '~> 1.1.2'
  gem 'factory_girl_rails'
  gem 'mongoid-rspec'
  gem 'launchy'
  #gem 'poltergeist' #js testing
end

gem 'client_side_validations'
gem 'kaminari'


gem 'newrelic_rpm'

gem "carrierwave"
gem 'carrierwave-mongoid', :require => 'carrierwave/mongoid'

#cache
gem 'cache_digests'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
