require 'spec_helper'
require 'report_test_data'

describe RawCollectlExecution do
  include ModelHelpers

  it_should_behave_like "read only model"

end