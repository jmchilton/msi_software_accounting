require 'spec_helper'

describe ExecutablesController do

  # This should return the minimal set of attributes required to create a valid
  # Executable. As you add validations to Executable, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  describe "GET index" do
    it "assigns all executables as @executables" do
      executable = Executable.create! valid_attributes
      get :index
      assigns(:executables).should include(executable)
    end
  end

  describe "GET show" do
    it "assigns the requested executable as @executable" do
      resource = FactoryGirl.create(:resource)
      executable = FactoryGirl.create(:executable, :resource => resource)
      get :show, :id => executable.id.to_s
        assigns(:executable).should eq(executable)
    end
  end

  describe "GET new" do
    it "assigns a new executable as @executable" do
      get :new
      assigns(:executable).should be_a_new(Executable)
    end
  end

  describe "GET edit" do
    it "assigns the requested executable as @executable" do
      executable = Executable.create! valid_attributes
      get :edit, :id => executable.id.to_s
      assigns(:executable).should eq(executable)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Executable" do
        expect {
          post :create, :executable => valid_attributes
        }.to change(Executable, :count).by(1)
      end

      it "assigns a newly created executable as @executable" do
        post :create, :executable => valid_attributes
        assigns(:executable).should be_a(Executable)
        assigns(:executable).should be_persisted
      end

      it "redirects to the created executable" do
        post :create, :executable => valid_attributes
        response.should redirect_to(Executable.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved executable as @executable" do
        # Trigger the behavior that occurs when invalid params are submitted
        Executable.any_instance.stub(:save).and_return(false)
        post :create, :executable => {}
        assigns(:executable).should be_a_new(Executable)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Executable.any_instance.stub(:save).and_return(false)
        post :create, :executable => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested executable" do
        executable = Executable.create! valid_attributes
        # Assuming there are no other executables in the database, this
        # specifies that the Executable created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Executable.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => executable.id, :executable => {'these' => 'params'}
      end

      it "assigns the requested executable as @executable" do
        executable = Executable.create! valid_attributes
        put :update, :id => executable.id, :executable => valid_attributes
        assigns(:executable).should eq(executable)
      end

      it "redirects to the executable" do
        executable = Executable.create! valid_attributes
        put :update, :id => executable.id, :executable => valid_attributes
        response.should redirect_to(executable)
      end
    end

    describe "with invalid params" do
      it "assigns the executable as @executable" do
        executable = Executable.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Executable.any_instance.stub(:save).and_return(false)
        put :update, :id => executable.id.to_s, :executable => {}
        assigns(:executable).should eq(executable)
      end

      it "re-renders the 'edit' template" do
        executable = Executable.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Executable.any_instance.stub(:save).and_return(false)
        put :update, :id => executable.id.to_s, :executable => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested executable" do
      executable = Executable.create! valid_attributes
      expect {
        delete :destroy, :id => executable.id.to_s
      }.to change(Executable, :count).by(-1)
    end

    it "redirects to the executables list" do
      executable = Executable.create! valid_attributes
      delete :destroy, :id => executable.id.to_s
      response.should redirect_to(executables_url)
    end
  end

end
