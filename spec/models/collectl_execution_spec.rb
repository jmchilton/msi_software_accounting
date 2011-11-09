require 'spec_helper'
require 'report_test_data'

COLLECTL_EXECUTABLE = "/usr/bin/bowtie"
START_TIME = Time.now - 3.days
END_TIME = Time.now - 5.days
UID = 10245


describe CollectlExecution do
  include ModelHelpers

  # it_should_behave_like "read only model"

  describe "index_raw_records" do
    let(:user) { FactoryGirl.create(:user, :uid => UID) }
    let(:executable) { FactoryGirl.create(:collectl_executable, :name => "bowtie") }
    let(:raw_execution1) { FactoryGirl.create(:raw_collectl_execution, :start_time => START_TIME, :end_time => END_TIME, :uid => user.uid, :executable => COLLECTL_EXECUTABLE) }
    let(:processed_execution1) { CollectlExecution.find raw_execution1.id }

    shared_examples_for "indexed executable" do
      it "should create a processed execution with same id as raw" do
        processed_execution1.id.should eql(raw_execution1.id)
      end

      specify { processed_execution1.start_time.should eql(raw_execution1.start_time) }
      specify { processed_execution1.end_time.should eql(raw_execution1.end_time) }
      specify { processed_execution1.host.should eql(raw_execution1.host) }
      specify { processed_execution1.pid.should eql(raw_execution1.pid) }
      specify { processed_execution1.user.should eql(user) }
      specify { processed_execution1.collectl_executable.should eql(executable) }

    end

    describe "indexing one executable" do
      before(:each) {
        raw_execution1
        CollectlExecution.index_raw_records executable.id
      }

      it_should_behave_like "indexed executable"
    end

    describe "indexing all" do
      before(:each) {
        raw_execution1
        executable
        CollectlExecution.index_raw_records
      }

      it_should_behave_like "indexed executable"

      it "should be able to reindex without breaking" do
        CollectlExecution.index_raw_records
      end

      describe "updating records" do

        it "should update end time" do
          time = Time.now
          raw_execution1.end_time = time
          raw_execution1.save
          CollectlExecution.index_raw_records
          processed_execution1.end_time.should eql(time)
        end

      end

    end

  end



end