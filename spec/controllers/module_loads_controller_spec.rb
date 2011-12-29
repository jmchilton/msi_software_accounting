require 'spec_helper'

describe ModuleLoadsController do

  def valid_params
    software_module = FactoryGirl.create(:module)
    user = FactoryGirl.create(:user)
    FactoryGirl.attributes_for(:module_load, :module => software_module, :user => user)
  end



  describe "POST create" do
    describe "with valid params" do
      it "creates a new module load instance" do
        expect {
          post :create, :module_load => valid_params
        }.to change(ModuleLoad, :count).by(1)
      end

      it "assigns a newly created purchase as @purchase" do
        post :create, :module_load => valid_params
        assigns(:module_load).should be_a(ModuleLoad)
        assigns(:module_load).should be_persisted
      end

      it "should return a good response code" do
        post :create, :module_load => valid_params
        response.response_code.should == 201
      end
    end

    describe "with invalid params" do
      before(:each) {
        ModuleLoad.any_instance.stub(:save).and_return(false)
        post :create, :module_load => {}
      }

      it "assigns a newly created but unsaved purchase as @module_load" do
        assigns(:module_load).should be_a_new(ModuleLoad)
      end

      it "should return an error response code" do
        response.response_code.should == 422 # unprocessible_entity
      end
    end
  end


end