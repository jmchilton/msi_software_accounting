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


  def find_record(&block)
    records.find &block
  end

  def should_have_record(&block)
    find_record(&block).should_not be_nil
  end

  def should_not_have_record(&block)
    find_record(&block).should be_nil
  end

  def report_test_resource
    Resource.find_by_name ReportTestData::RESOURCE_NAME_1
  end

  def setup_test_report_data
    ReportTestData.setup_medical_resources_and_events
  end

end