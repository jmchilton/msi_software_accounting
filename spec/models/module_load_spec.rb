require 'spec_helper'

describe ModuleLoad do

  it "should specify default date" do
    ModuleLoad.new.date.should_not be_nil
  end

end
