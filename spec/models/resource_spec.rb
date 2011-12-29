require 'spec_helper'

describe Resource do
  include ModelHelpers
  include HasSummary

  it_should_behave_like "read only model"

  describe "summarize" do
    describe "collectl" do
      let(:instance) { FactoryGirl.create(:resource)}
      let(:collectl_executable) { FactoryGirl.create(:collectl_executable, :name => "bowtie", :resource => instance) }
      let(:summary) { instance.summarize("collectl") }

      before(:each) {
        setup_collectl_executions(collectl_executable)
      }

      it_should_behave_like "has summary"

    end

    describe "flexlm" do
      let(:instance) { FactoryGirl.create(:resource)}
      let(:executable) { FactoryGirl.create(:executable, :identifier => "bowtie", :resource => instance) }
      let(:summary) { instance.summarize("flexlm") }

      before(:each) {
        setup_flexlm_events(executable)
      }

      it_should_behave_like "has summary"
    end

  end

  describe "report" do
    let(:relation) { Resource.report(report_options) }

    let(:non_tech_record) { record_with_name ReportTestData::NON_TECH_RESOURCE_NAME }
    let(:tech_record) { record_with_name ReportTestData::TECH_RESOURCE_NAME }

    describe "flexlm version" do
      before(:each) { ReportTestData.setup_two_resources(:collectl => false) }

      describe "excludes_employees option" do
        it_should_behave_like "flexlm report that excludes employees"
        it_should_behave_like "flexlm report that does not exclude employees"
      end

      describe "limit_users options" do
        it_should_behave_like "flexlm report that can limit users"
      end
    end

    describe "collectl version" do
      before(:each) { ReportTestData.setup_two_resources(:flexlm => false) }

      describe "excludes_employees option" do
        it_should_behave_like "collectl report that excludes employees"
        it_should_behave_like "collectl report that does not exclude employees"
      end

      describe "limit_users options" do
        it_should_behave_like "collectl report that can limit users"
      end

    end

    describe "module version" do
      before(:each) { ReportTestData.setup_two_resources(:module => true) }

      describe "excludes_employees option" do
        it_should_behave_like "module report that excludes employees"
        it_should_behave_like "module report that does not exclude employees"
      end

      describe "limit_users options" do
        it_should_behave_like "module report that can limit users"
      end

    end

  end


  describe "report with fixtures" do #deprecated
    let(:record1) { Resource.report(:data_source => :flexlm).find_by_id(1)  }

    it "should include correct purchase totals" do
      record1.fy11.should eql(20)
      record1.fy10.should == 10 
      record1.fy12.should == 25 
      record1.fy13.should == 0 
    end

    it "should include resource name" do
      record1.name.should == "resource_1"
    end

    it "should find records in range" do
      Resource.report(:from => '2011-09-01', :to => '2011-09-02', :data_source => :flexlm).find_by_id(3).num_users.should == 1
    end

    it "should not find records for events after range" do
      Resource.report(:from => "2011-09-05", :to => "", :data_source => :flexlm).find_by_id(3).should be_blank
    end

    it "should not find records for events before range" do
      Resource.report(:from => nil, :to => "2011-08-04", :data_source => :flexlm).find_by_id(3).should be_blank
    end

  end

  it "should have msi_db_link" do
    resource = FactoryGirl.create(:resource)
    resource.msi_db_link.should == "#{StaticData::MSIDB_CRUD_URL}sw/resource/#{resource.id}/view"
  end

end
