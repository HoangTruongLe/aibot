source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.1'
# Use postgres as the database for Active Record
gem 'pg', '~> 0.18.4'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

#jquery-rails for remote paginate
gem 'jquery-rails', '~> 4.3', '>= 4.3.1'

# Manage API Version
gem 'versionist'

# Manage Environment Variable
gem 'dotenv-rails'

# Devise authentication
gem 'devise'
gem "devise-async", '~> 1.0.0'
gem 'rolify'
gem 'cancancan'

# Rail admin
gem 'omniauth'
gem 'rails_admin', '~> 1.2'

# Simple form for
gem 'simple_form'
gem 'country_select'

#Soft deleted
gem "paranoia", "~> 2.2"

# Paging
gem 'kaminari'

gem "font-awesome-rails"
gem "breadcrumbs_on_rails"

gem 'rack-cors', :require => 'rack/cors'

# Object-based searching.
gem 'ransack', github: 'activerecord-hackery/ransack'

#Simple, efficient background processing for Ruby.
gem 'sidekiq'
gem 'sendgrid'

# association
gem "cocoon"
gem 'whenever', '~> 0.9.7'
gem 'enumerize', '~> 2.1', '>= 2.1.2'

# Bootstrap Calender
gem 'momentjs-rails', '>= 2.9.0'
gem 'bootstrap3-datetimepicker-rails', '~> 4.14.30'

#images and videos uploader
gem 'paperclip', '~> 5.1'
gem 'paperclip-av-transcoder'
# gem 'rmagick'
gem 'dropzonejs-rails'
gem 'aws-sdk', '~> 2.3.0'
gem "paperclip-ffmpeg"
gem "jquery-fileupload-rails"
# sudo add-apt-repository ppa:mc3man/trusty-media
# sudo apt-get update
# sudo apt-get dist-upgrade
# sudo apt-get install ffmpeg

#delayed_job
gem 'delayed_job_active_record', '~> 4.1', '>= 4.1.1'

# Editor
gem "wysiwyg-rails"

# Get metadata from URL
gem 'metainspector'

# ranked model
gem 'ranked-model'

# Datatable
gem 'jquery-datatables-rails', '~> 3.4.0'

# gem config
gem 'config'

gem 'searchkick'

#models sanitizer
gem 'sanitize_model_attributes', '~> 0.0.7'

gem 'paperclip-i18n'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  # Adds support for Unit testing
  gem 'rspec-rails', '~> 3.5'
  gem 'factory_bot_rails', '~> 4.8', '>= 4.8.2'
  gem 'ffaker'
  gem 'faker', '~> 1.8', '>= 1.8.4'
  gem 'seed-fu', '~> 2.3', '>= 2.3.6'
  gem 'awesome_print'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # Checking N + 1 query
  gem 'bullet'

  # Use Capistrano for deployment
  gem 'capistrano', '~> 3.6'
  gem 'capistrano-rails', '~> 1.3'
  gem 'capistrano-rbenv'
  gem 'capistrano-sidekiq'
  gem 'capistrano3-nginx', '~> 2.0'
end

group :test do
	gem 'simplecov', '~> 0.14.1', require: false
	gem 'shoulda-matchers', '~> 3.1'
	gem 'database_cleaner', '~> 1.6'
	# assigns in controller rspec has been extracted to a gem
	gem 'rails-controller-testing', '~> 1.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
