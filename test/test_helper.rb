ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  set_fixture_class :swacct_purchases => Purchase
  set_fixture_class :swacct_resources => Resource
  set_fixture_class :swacct_executable => Executable
  set_fixture_class :swacct_event => Event
  set_fixture_class :people_people => Person
  set_fixture_class :people_users => User
  set_fixture_class :people_groups => Group
  set_fixture_class :people_departments => Department
  set_fixture_class :people_colleges => College

  fixtures :all

  # Add more helper methods to be used by all tests here...
end
