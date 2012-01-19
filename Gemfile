source 'http://rubygems.org'

gem 'rails', '3.0.10'

gem 'fastercsv'

gem 'zippy'

gem 'basic_model'

gem 'jquery-rails'

gem 'compass'

gem 'rails3-jquery-autocomplete'

gem 'sqlite3'

gem 'whenever'

gem 'aliased_sql', :git => 'git://github.com/jmchilton/aliased_sql.git'

group :production do 
  gem 'postgres'
  gem 'pg'
end

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
# gem 'ruby-debug'
# gem 'ruby-debug19', :require => 'ruby-debug'

group :development, :test do
  gem "rcov"
  gem "guard"
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
  gem 'assembly_line'
  gem 'factory_girl_rails'
  gem "capybara"
  gem "rspec-rails", "2.6"
  gem "ci_reporter", :git => "git://github.com/nicksieger/ci_reporter.git"
end