describe User do

  describe "resource_report" do
    let(:report1) { User.resource_report(1) }
    let(:alices_record) { record_for(report1, 'alice') }

    it "should have record of user using software" do
      alices_record.should_not be_blank
    end
 
    it "should not have record of users who have not used software" do
      record_for(report1, 'bob').should be_blank
    end

    it "should find events in date range" do
      report = User.resource_report(3, '2011-09-01', '2011-09-02')
      record_for(report, "shelly").should_not be_blank
    end

    it "should not find events before date range" do
      report = User.resource_report(3, '2011-09-02', '2011-09-03')
      record_for(report, "shelly").should be_blank
    end

    it "should not find events after date range" do
      report = User.resource_report(3, '2011-06-02', '2011-07-03')
      record_for(report, "shelly").should be_blank
    end

  end

  def record_for(records, user)
    records.find { |record| record.username == user}
  end

end
