source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end
ruby "2.4.4"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.6'
# Use Puma as the app server
gem 'puma', '~> 3.7'

gem 'knock'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use postgresql as the database for Active Record
gem 'pg'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

gem 'bootstrap-sass', '~> 3.3.7'
gem "d3-rails"
gem 'table_print'

gem 'httparty'
# Use Capistrano for deployment
#gem 'capistrano-rails', group: :development

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors', :require => 'rack/cors'
## Gemfile for Rails 3+, Sinatra, and Merb
gem 'will_paginate', '~> 3.1.0'
gem 'faker', '~> 1.8', '>= 1.8.7'

gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'
gem 'groupdate'
# serializers gem
gem 'active_model_serializers', '~> 0.10.0'

gem 'mini_magick'
gem 'carrierwave'

gem 'delayed_job_active_record'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'annotate'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
