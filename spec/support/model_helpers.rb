require 'report_test_data'

module ModelHelpers
  share_examples_for "read only model" do
    it "should prevent deletion" do
      lambda { subject.delete }.should raise_error(ActiveRecord::ReadOnlyRecord)
    end

    it "class should prevent delete all" do
      lambda { subject.class.delete_all }.should raise_error(ActiveRecord::ReadOnlyRecord)
    end

    it "should be read_only" do
      subject.readonly?.should == true
    end

  end

  share_examples_for "resource report that can exclude employees" do
    before(:each) { ReportTestData.setup_two_resources }

      describe "excluding employees" do
        let(:report_options) { { :exclude_employees => true }}

        specify { tech_record.should be_nil }

      end

      describe "not excluding employees" do
        let(:report_options) { { :exclude_employees => false }}

        specify { tech_record.should_not be_nil }
      end
  end

  shared_examples_for "report that can exclude employees" do
    before(:each) { setup_test_used_twice_data }
    let(:resource_id) { Resource.find_by_name(ReportTestData::USED_TWICE_RESOURCE_NAME).id }
    let(:executable_id) { Executable.find_by_identifier(ReportTestData::USED_TWICE_EXECUTABLE_IDENTIFIER).exid }

    it_should_behave_like "report that excludes employees"
    it_should_behave_like "report that does not exclude employees"

  end

  shared_examples_for "report that does not exclude employees" do
    describe "not excluding employees" do
      let(:report_options) { { :exclude_employees => false } }

      specify { tech_record.should_not be_nil }
      specify { non_tech_record.should_not be_nil }
    end

  end

  shared_examples_for "report that excludes employees" do
    describe "excluding employees" do
      let(:report_options) { { :exclude_employees => true } }

      specify { tech_record.should be_nil }
      specify { non_tech_record.should_not be_nil }
    end

  end


  def records
    relation.all
  end

  def record_count
    records.count
  end

  #TODO: Merge these methods into on method messing method record_with_XXXX
  def record_with_name(name)
    find_record { |record| record.name == name }
  end

  def record_with_identifier(value)
    find_record { |record| record.identifier == value }
  end

  def record_with_resource(value)
    find_record { |record| record.resource == value }
  end


  def find_record(&block)
    records.find &block
  end

  def should_have_record(&block)
    find_record(&block).should_not be_nil
  end

  def should_not_have_record(&block)
    find_record(&block).should be_nil
  end

  def should_have_record_with_name(name)
    find_record { |record| record.name == name }.should_not be_nil
  end

  def should_not_have_record_with_name(name)
    find_record { |record| record.name == name }.should be_nil
  end

  def report_test_resource
    Resource.find_by_name ReportTestData::RESOURCE_NAME_1
  end

  def setup_test_report_data
    ReportTestData.setup_medical_resources_and_events
  end

  def setup_test_used_twice_data
    ReportTestData.setup_used_twice_resource
  end

end