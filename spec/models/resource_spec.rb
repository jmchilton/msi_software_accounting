describe Resource do

  describe "report" do
    let(:record1) { Resource.report.find { |record| record.id == 1 }  }

    it "should include correct purchase totals" do
      record1.fy11.should eql(20)
      record1.fy10.should == 10 
      record1.fy12.should == 25 
      record1.fy13.should == 0 
    end

    it "should include resource name" do
      record1.name.should == "resource_1"
    end

  end

end
