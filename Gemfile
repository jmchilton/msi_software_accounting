source 'http://rubygems.org'

gem 'ci_reporter'

gem 'rails', '3.0.9'

gem 'fastercsv'

gem 'basic_model'

gem 'jquery-rails'

gem 'compass'

gem 'rails3-jquery-autocomplete'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'

group :production do 
  gem 'postgres'
  gem 'pg'
end

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
# gem 'ruby-debug'
# gem 'ruby-debug19', :require => 'ruby-debug'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
# group :development, :test do
#   gem 'webrat'
# end

group :development, :test do
  gem "rcov"
  gem "guard-rspec"
  if RbConfig::CONFIG['target_os'] =~ /darwin/i
    gem 'rb-fsevent', '>= 0.4.0', :require => false
  end
  if RbConfig::CONFIG['target_os'] =~ /linux/i
    gem 'rb-inotify', '>= 0.8.5', :require => false
  end
  gem "guard-livereload"
end

group :test do
  gem 'factory_girl_rails'
  gem "capybara"
  gem "rspec-rails", ">= 2"
end