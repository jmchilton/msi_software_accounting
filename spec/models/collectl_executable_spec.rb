require 'spec_helper'

describe CollectlExecutable do
  include ModelHelpers
  include HasSummary


  describe "destroy" do

    it "should delete dependent executions" do
      executable = FactoryGirl.create(:collectl_executable, :name => "bowtie")
      execution = FactoryGirl.create(:collectl_execution, :collectl_executable => executable)
      execution_id = execution.id
      CollectlExecution.exists?(execution_id).should be_true
      executable.destroy
      CollectlExecution.exists?(execution_id).should be_false
    end

  end

  describe "summarize" do
    let(:instance) { FactoryGirl.create(:collectl_executable, :name => "bowtie") }

    before(:each) {
      setup_collectl_executions(instance)
    }

    it_should_behave_like "has direct summary"
  end

end