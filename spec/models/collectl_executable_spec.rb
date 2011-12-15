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
      FactoryGirl.create(:collectl_execution, :collectl_executable => instance, :start_time => '2011-08-05 12:10:38')
      FactoryGirl.create(:collectl_execution, :collectl_executable => instance, :start_time => '2011-08-06 12:10:38')
      FactoryGirl.create(:collectl_execution, :collectl_executable => instance, :start_time => '2011-08-07 12:10:38')
    }

    it_should_behave_like "has summary"
  end

end