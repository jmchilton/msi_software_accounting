describe Purchase do
  describe "resource summary" do 
    let(:record1) { Purchase.resource_summary.find { |record| record.rid == 1 } }

    it "should contain valid sums for fy10" do
      record1.fy10.should eql(10)
    end

  end

  describe "factory" do
    it "should have an id" do
      purchase = FactoryGirl.create(:purchase)
      purchase.pid.should_not be_blank
    end

    specify "created purchases should be able to be found" do
      purchase = FactoryGirl.create(:purchase)
      found_purchase = Purchase.find(purchase.pid)
      found_purchase.should_not be_blank
      found_purchase.pid.should == purchase.pid
    end
  end

end
