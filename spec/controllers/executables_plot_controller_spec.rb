require 'spec_helper'

DUMMY_DATE=DateTime.now

describe ExecutablesPlotController do
  before(:each) {
    @snapshot = FactoryGirl.create(:flexlm_app_snapshot)
    @executable = @snapshot.executable
  }

  describe "GET 'new'" do
    it "should be successful" do
      get 'new', :executable_id => @executable.exid
      response.should be_success
    end
  end

  describe "GET 'index' with default params" do

    before(:each) {
      FlexlmAppSnapshot.stub!(:sample_for_executable).with(@executable.exid, instance_of(Hash)).and_return([{:value => 5, :total_licenses => 10, :for_date => DUMMY_DATE}])
      get 'index', :executable_id => @executable.exid
    }

    it "should be successful" do
      response.should be_success
    end

    specify { it_should_chart_point DUMMY_DATE, 5 }
    specify { it_should_chart_point DUMMY_DATE, 10 }
    specify { assigns(:executable) == @executable }

  end

  describe "GET 'index' with subsampling" do
    before(:each) {
      FlexlmAppSnapshot.stub!(:sample_for_executable).with(@executable.exid, hash_including(:sample => 'date', :sample_with => 'avg')).and_return([{:value => 5, :total_licenses => 10, :for_date => DUMMY_DATE}])
      FlexlmAppSnapshot.stub!(:sample_for_executable).with(@executable.exid, hash_including(:sample => 'date', :sample_with => 'max')).and_return([{:value => 7, :total_licenses => 10, :for_date => DUMMY_DATE}])
      get 'index', :executable_id => @executable.exid, :sample => 'date'
    }

    specify { it_should_chart_point DUMMY_DATE, 5  }
    specify { it_should_chart_point DUMMY_DATE, 7  }
    specify { it_should_chart_point DUMMY_DATE, 10 }

  end

  def it_should_chart_point(date, value)
    assigned_chart_with_data_point(date, value).should be_true
  end

  def assigned_chart_with_data_point(date, value)
    found = false
    js_date = date.to_time.to_i * 1000
    assigns(:chart_data).data.each do |data|
      data_array = data[:data]
      data_array.each do |tuple|
        if tuple[0] == js_date && tuple[1] == value
          found = true
        end
      end
    end
    found
  end

end
