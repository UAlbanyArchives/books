source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.7'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.1.7.3'
# Use sqlite3 as the database for Active Record
gem 'sqlite3', '~> 1.6.2'
# Use Puma as the app server
gem 'puma', '~> 5.6.4'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
# gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# Customizations
gem 'blacklight', '>= 7.33'
gem 'blacklight_range_limit'
gem "font-awesome-rails"

# shared header, footer, etc.
#gem 'grenander', git: 'https://github.com/UAlbanyArchives/grenander', branch: "bs4_migration"
gem 'grenander', git: 'https://github.com/UAlbanyArchives/grenander', ref: "e4e0fd5495860792d326fecbab545dfc4b1dafcf"
#gem 'grenander', path: 'grenander'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

group :development, :test do
  gem 'solr_wrapper', '>= 0.3'
end

gem 'rsolr', '>= 1.0', '< 3'
gem 'bootstrap', '~> 4.0'
gem 'twitter-typeahead-rails', '0.11.1.pre.corejavascript'
gem 'jquery-rails'

gem "rename"

#maintenance updates
gem "addressable", ">= 2.8.0"
gem "nokogiri", ">= 1.13.4"
gem "rack", ">= 2.2.6.4"
