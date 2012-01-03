require 'spec_helper'

describe ExecutableModelReportController do
  include TableHelpers
  include UsageReportHelpers

  before_each_setup_parent

  it_should_behave_like "controller with usage reports for each model type"
end
