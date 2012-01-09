# http://kpumuk.info/ruby-on-rails/my-top-7-rspec-best-practices/
# figure out where we are being loaded from
if $LOADED_FEATURES.grep(/spec\/spec_helper\.rb/).any?
  begin
    raise "foo"
  rescue => e
    puts <<-MSG
  ===================================================
  It looks like spec_helper.rb has been loaded
  multiple times. Normalize the require to:

    require "spec/spec_helper"

  Things like File.join and File.expand_path will
  cause it to be loaded multiple times.

  Loaded this time from:

    #{e.backtrace.join("\n    ")}
  ===================================================
    MSG
  end
end

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'capybara/rails'
require 'capybara/dsl'


# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
#Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}
['has_summary', 'page_helpers', 'helpers', 'integration_helpers', 'model_helpers', 'overview_helpers',  'table_helpers', 'usage_report_helpers', 'view_helpers'].each do |f|
  require "spec/support/#{f}.rb"
end

RSpec.configure do |config|
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec
  config.render_views

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  #config.fixture_path = "#{::Rails.root}/test/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  config.include(Capybara, :type => :integration)

  config.global_fixtures = :all
end

Capybara.add_selector(:data_table_header) do
  xpath { ".//table[id=data_table]/tr[1]" }
end
