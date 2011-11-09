require 'spec_helper'

describe CollectlExecutable do
  include ModelHelpers


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


end