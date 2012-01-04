require 'spec_helper'

describe ResourceMappablesController do
  include TableHelpers

  before(:each) {
    setup_parent_resource
  }

  def valid_attributes
    {:name => "Moo", :resource_id => resource.id}
  end

  it_should_behave_like "standard model GET index"

  describe "GET show" do
    it "assigns the requested executable as @collectl_executable" do
      collectl_executable = FactoryGirl.create(:collectl_executable, :resource => resource)
      get :show, :id => collectl_executable.id.to_s, :resource_id => resource.id
      assigns(:collectl_executable).should eq(collectl_executable)
    end
  end

  describe "GET new" do
    it "assigns a new collectl_executable as @collectl_executable" do
      get :new, :resource_id => resource.id
      assigns(:collectl_executable).should be_a_new(CollectlExecutable)
    end
  end

  describe "POST create" do

    def do_post
      post :create, :collectl_executable => valid_attributes, :resource_id => resource.id
    end

    describe "with valid params" do
      it "creates a new Executable" do
        expect { do_post }.to change(CollectlExecutable, :count).by(1)
      end

      it "assigns a newly created executable as @executable" do
        do_post
        assigns(:collectl_executable).should be_a(CollectlExecutable)
        assigns(:collectl_executable).should be_persisted
      end

      it "redirects to the created executable" do
        do_post
        response.should redirect_to(resource_mappables_path(:resource_id => resource.id))
      end
    end

    describe "with invalid params" do
      def stub_save
        CollectlExecutable.any_instance.stub(:save).and_return(false)
      end

      it "assigns a newly created but unsaved collectl executable as @collectl_executable" do
        # Trigger the behavior that occurs when invalid params are submitted
        stub_save
        do_post
        assigns(:collectl_executable).should be_a_new(CollectlExecutable)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        stub_save
        do_post
        response.should render_template("new")
      end
    end

  end

  describe "DELETE destroy" do
    before(:each) {
      @collectl_executable = FactoryGirl.create(:collectl_executable, :resource => resource)
    }

    def do_destroy
      delete :destroy, :id => @collectl_executable.id.to_s, :resource_id => resource.id
    end

    it "destroys the requested executable" do
      expect {
        do_destroy
      }.to change(CollectlExecutable, :count).by(-1)
    end

    it "redirects to the executables list" do
      do_destroy
      response.should redirect_to(resource_mappables_path(:resource_id => resource.id))
    end
  end

end