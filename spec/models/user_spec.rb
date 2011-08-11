describe User do

  describe "user_report" do
    let(:report1) { User.resource_report(1) }
    let(:alices_record) { report1.find { |record| record.username == 'alice' } }

    it "should have record of user using software" do
      alices_record.should_not be_blank
    end
 
    it "should not have record of users who have not used software" do
      report1.find { |record| record.username == 'bob' }.should be_blank
    end

  end  

end
