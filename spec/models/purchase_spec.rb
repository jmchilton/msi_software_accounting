require 'spec_helper'

describe Purchase do

  describe "resource summary" do 
    let(:record1) { Purchase.resource_summary.find { |record| record.rid == 1 } }

    it "should contain valid sums for fy10" do
      record1.fy10.should eql(10)
    end

  end

  describe "validation" do
    before(:each) {
      resource = FactoryGirl.create(:resource)
      @purchase = FactoryGirl.build(:purchase, :resource => resource)
    }

    it "should require a resource" do
      @purchase.should be_valid
      @purchase.resource = nil
      @purchase.should_not be_valid
    end

    it "should require valid cost for fy10" do
      @purchase.should be_valid
      @purchase.fy10 = -100
      @purchase.should_not be_valid
    end

    it "should require valid cost fy11" do
      @purchase.should be_valid
      @purchase.fy11 = "test"
      @purchase.should_not be_valid
    end

  end

  describe "factory" do
    it "should have an id" do
      purchase = FactoryGirl.create(:purchase, :resource => FactoryGirl.create(:resource))
      purchase.pid.should_not be_blank
    end

    specify "created purchases should be able to be found" do
      purchase = FactoryGirl.create(:purchase, :resource => FactoryGirl.create(:resource))
      found_purchase = Purchase.find(purchase.pid)
      found_purchase.should_not be_blank
      found_purchase.pid.should == purchase.pid
    end
  end

end
