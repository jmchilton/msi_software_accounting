require 'spec_helper'

describe SoftwareModule do
  include ModelHelpers
  include HasSummary

  describe "summarize" do
    let(:instance) { FactoryGirl.create(:module, :name => "bowtie") }

    before(:each) {
      setup_module_loads(instance)
    }

    it_should_behave_like "has direct summary"
  end

end