require 'spec_helper'
require 'report_test_data'

COLLECTL_EXECUTABLE = "/usr/bin/bowtie"
START_TIME = Time.now.beginning_of_day - 3.days
END_TIME = Time.now.beginning_of_day - 5.days
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

      it "should have a non-nil start time" do
        processed_execution1.start_time.should_not be_nil
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


  describe "sample_for_executable" do

    before(:each) {
      @user1 = FactoryGirl.create(:user)
      @user2 = FactoryGirl.create(:user)
      @collectl_executable1 = FactoryGirl.create(:collectl_executable)
      @collectl_executable2 = FactoryGirl.create(:collectl_executable)
      @execution1 = FactoryGirl.create(:collectl_execution, :start_time => '2011-09-01 01:00:00', :end_time => '2011-09-01 01:30:00', :collectl_executable => @collectl_executable1, :user => @user1)
      @execution2 = FactoryGirl.create(:collectl_execution, :start_time => '2011-09-01 01:25:00', :end_time => '2011-09-01 03:30:00', :collectl_executable => @collectl_executable1, :user => @user2)
      @execution3 = FactoryGirl.create(:collectl_execution, :start_time => '2011-09-01 00:25:00', :end_time => '2011-09-01 03:30:00', :collectl_executable => @collectl_executable2, :user => @user1)

      @next_day_execution1 = FactoryGirl.create(:collectl_execution, :start_time => '2011-09-02 01:00:00', :end_time => '2011-09-02 01:30:00', :collectl_executable => @collectl_executable1, :user => @user1)
    }

    let(:to) { '2011-09-03' }
    let(:from) { '2011-09-01' }
    let(:samples) { CollectlExecution.sample_for_executable(@collectl_executable1.id, {:sample => sample_grouping, :sample_with => sample_with, :from => from, :to => to}) }
    let(:sample) { samples[0] }

    describe "sampling date range" do
      let(:sample_grouping) { "date" }
      let(:sample_with) { "max" }
      let(:from) { '2011-09-02' }

      it "should restrict usage to just one user" do
        sample[:value].should eql(1)
      end

    end

    describe "sampling date with" do
      let(:sample_grouping) { "date" }

      describe "max" do
        let(:sample_with) { "max" }

        it "should register 2 uses" do
          sample[:value].should eql(2)
        end

        it "should have associated date field" do
          sample[:for_date].should eql('2011-09-01')
        end

      end

      describe "avg" do
        let(:sample_with) { "avg" }

        it "should have less than max usage, but greater than 0" do
          sample[:value].should be < 2
          sample[:value].should be > 0
        end


      end

    end

    describe "sampling continously" do
      let(:sample_grouping) { "" }
      let(:sample_with) { "max" }

      specify { sample[:value].should == 1 }
      specify { samples.find { |x| x[:for_date] == '2011-09-01 01:30:00'}[:value].should == 2 }

    end

  end




end