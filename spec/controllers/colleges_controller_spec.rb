require "spec_helper"

describe CollegesController do
  include TableHelpers

  describe "GET index" do
    before(:each) { get :index }
    specify { response.should be_success }
    specify { response.should render_template("index") }
  end

  describe "GET show" do
    let(:college) { FactoryGirl.create(:college) }
    before(:each) {
      id = college.id
      College.stub!(:find).with(id).and_return(college)
      get :show, :id => college.id
    }

    specify { response.should be_success }
    specify { response.should render_template("show")}
    specify { assigns(:college).should == college }
  end

end