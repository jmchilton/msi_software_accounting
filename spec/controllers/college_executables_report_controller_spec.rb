require 'spec_helper'

describe CollegeExecutablesReportController do
  include TableHelpers
  include UsageReportHelpers

  before_each_setup_parent

  it_should_behave_like "standard report GET new"
  it_should_behave_like "standard usage report GET index"
end
