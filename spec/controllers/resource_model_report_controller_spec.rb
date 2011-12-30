require 'spec_helper'

describe ResourceModelReportController do
  include TableHelpers
  include UsageReportHelpers

  before_each_setup_parent

  it_should_behave_like "controller with usage reports for each model type"
end
