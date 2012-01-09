require 'spec_helper'

describe Resource do
  include ModelHelpers
  include HasSummary

  it_should_behave_like "read only model"

  describe "summarize" do
    describe "collectl" do
      let(:instance) { FactoryGirl.create(:resource) }
      let(:collectl_executable) { FactoryGirl.create(:collectl_executable, :name => "bowtie", :resource => instance) }
      let(:summary) { instance.summarize(:collectl) }

      before(:each) {
        setup_collectl_executions(collectl_executable)
      }

      it_should_behave_like "has summary"

    end

    describe "flexlm" do
      let(:instance) { FactoryGirl.create(:resource)}
      let(:executable) { FactoryGirl.create(:executable, :identifier => "bowtie", :resource => instance) }
      let(:summary) { instance.summarize(:flexlm) }

      before(:each) {
        setup_flexlm_events(executable)
      }

      it_should_behave_like "has summary"
    end

    describe "modules" do
      let(:instance) { FactoryGirl.create(:resource) }
      let(:software_module) { FactoryGirl.create(:module, :resource => instance, :name => "bowtie") }
      let(:summary) { instance.summarize(:module) }

      before(:each) { setup_module_loads(software_module) }

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


  it "should have msi_db_link" do
    resource = FactoryGirl.create(:resource)
    resource.msi_db_link.should == "#{StaticData::MSIDB_CRUD_URL}sw/resource/#{resource.id}/view"
  end

end
