source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
# Use Postgres as the databse for Active Record
gem 'pg'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

#Paginate Gem
gem 'will_paginate', '~> 3.1.0'

# Rails 4 does not render static assets on heroku by default
gem 'rails_12factor', group: :production

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri

  # Use RSpec for specs
  gem 'rspec-rails'

  # Use Factory Girl for generating random test data
  gem 'factory_girl_rails'
  gem 'ffaker'
  gem "shoulda-matchers"
end

group :development do
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Magic authentication
gem 'sorcery' 

#Roles!
gem 'cancancan'

# Email format validator
gem 'validates_email_format_of'

# JWT (short for JSON Web Token)
gem 'jwt'  

# API documentation
gem 'apipie-rails'

#Creating services between models and controllers
gem 'simple_command'

# Serialize json response
gem 'active_model_serializers', '~> 0.10.0'

# OpenToken Video-Chat sessions
gem "opentok", "~> 2.3"

# Background Jobs
gem 'delayed_job_active_record'
