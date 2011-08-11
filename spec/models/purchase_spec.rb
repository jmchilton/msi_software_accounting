describe Purchase do
  describe "resource summary" do 
    let(:record1) { Purchase.resource_summary.find { |record| record.rid == 1 } }

    it "should contain valid sums for fy10" do
      record1.fy10.should eql(10)
    end

  end
end
