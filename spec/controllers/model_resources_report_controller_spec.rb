require 'spec_helper'

describe ModelResourcesReportController do
  include TableHelpers
  include UsageReportHelpers

  before_each_setup_parent

  describe "user reports" do
    let(:model_class) { User }
    let(:model_type) { "user" }

    it_should_behave_like "standard report GET new"
    it_should_behave_like "standard usage report GET index"
  end

  describe "college reports" do
    let(:model_class) { College }
    let(:model_type) { "college" }

    it_should_behave_like "standard report GET new"
    it_should_behave_like "standard usage report GET index"
  end

  describe "department reports" do
    let(:model_class) { Department }
    let(:model_type) { "department" }

    it_should_behave_like "standard report GET new"
    it_should_behave_like "standard usage report GET index"
  end

  describe "group reports" do
    let(:model_class) { Group }
    let(:model_type) { "group" }

    it_should_behave_like "standard report GET new"
    it_should_behave_like "standard usage report GET index"
  end

end
