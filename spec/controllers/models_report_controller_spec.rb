require 'spec_helper'

describe ModelsReportController do
  include TableHelpers


  shared_examples_for "models report" do
    it_should_behave_like "standard report GET new"

    describe "report GET index" do

      before(:each) {
        stub_report_method(model_class, :report)
      }

      it_should_behave_like "standard report GET index"
    end

  end

  describe "for departments" do
    let(:model_class) { Department }
    let(:model_type) { "department" }

    it_should_behave_like "models report"
  end

  describe "for colleges" do
    let(:model_class) { College }
    let(:model_type) { "college" }

    it_should_behave_like "models report"
  end

  describe "for groups" do
    let(:model_class) { Group }
    let(:model_type) { "group" }

    it_should_behave_like "models report"
  end

end
