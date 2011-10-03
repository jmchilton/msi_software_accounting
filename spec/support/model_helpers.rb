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
end