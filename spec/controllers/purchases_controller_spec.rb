require 'spec_helper'

describe PurchasesController do
  include TableHelpers

  before(:each) {
    @resource = FactoryGirl.create(:resource, :name => "test_resource_for_purchase")
  }

  def valid_attributes
    FactoryGirl.attributes_for(:purchase, :resource => @resource)
  end

  def valid_params
    valid_params = valid_attributes
    valid_params.delete(:resource_id)
    valid_params
  end

  describe "GET index" do
    before(:each) {
      purchase = Purchase.create! valid_attributes
      get 'index'
    }

    specify { it_should_respond_successfully_with_paginating_table }
    specify { it_should_assign_links_with "purchase_path" }
  end

  describe "GET show" do
    it "assigns the requested purchase as @purchase" do
      purchase = Purchase.create! valid_attributes
      get :show, :id => purchase.id.to_s
      assigns(:purchase).should eq(purchase)
    end
  end

  describe "GET new" do
    it "assigns a new purchase as @purchase" do
      get :new
      assigns(:purchase).should be_a_new(Purchase)
    end
  end

  describe "GET edit" do
    it "assigns the requested purchase as @purchase" do
      purchase = Purchase.create! valid_attributes
      get :edit, :id => purchase.pid.to_s
      assigns(:purchase).should eq(purchase)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Purchase" do
        expect {
          post :create, :purchase => valid_params, :resource_name => @resource.name
        }.to change(Purchase, :count).by(1)
      end

      it "assigns a newly created purchase as @purchase" do
        post :create, :purchase => valid_params, :resource_name => @resource.name
        assigns(:purchase).should be_a(Purchase)
        assigns(:purchase).should be_persisted
      end

      it "redirects to the created purchase" do
        post :create, :purchase => valid_params, :resource_name => @resource.name
        response.should redirect_to(Purchase.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved purchase as @purchase" do
        # Trigger the behavior that occurs when invalid params are submitted
        Purchase.any_instance.stub(:save).and_return(false)
        post :create, :purchase => {}, :resource_name => @resource.name
        assigns(:purchase).should be_a_new(Purchase)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Purchase.any_instance.stub(:save).and_return(false)
        post :create, :purchase => {}, :resource_name => @resource.name
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested purchase" do
        purchase = Purchase.create! valid_attributes
        # Assuming there are no other purchases in the database, this
        # specifies that the Purchase created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Purchase.any_instance.should_receive(:update_attributes).with({'these' => 'params', 'rid' => @resource.id})
        put :update, :id => purchase.to_param, :purchase => {'these' => 'params'}, :resource_name => @resource.name
      end

      it "assigns the requested purchase as @purchase" do
        purchase = Purchase.create! valid_attributes
        put :update, :id => purchase.to_param, :purchase => valid_params, :resource_name => @resource.name
        assigns(:purchase).should eq(purchase)
      end

      it "redirects to the purchase" do
        purchase = Purchase.create! valid_attributes
        put :update, :id => purchase.to_param, :purchase => valid_params, :resource_name => @resource.name
        response.should redirect_to(purchase)
      end
    end

    describe "with invalid params" do
      it "assigns the purchase as @purchase" do
        purchase = Purchase.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Purchase.any_instance.stub(:save).and_return(false)
        put :update, :id => purchase.to_param.to_s, :purchase => {}, :resource_name => @resource.name
        assigns(:purchase).should eq(purchase)
      end

      it "re-renders the 'edit' template" do
        purchase = Purchase.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Purchase.any_instance.stub(:save).and_return(false)
        put :update, :id => purchase.to_param.to_s, :purchase => {}, :resource_name => @resource.name
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested purchase" do
      purchase = Purchase.create! valid_attributes
      expect {
        delete :destroy, :id => purchase.to_param.to_s
      }.to change(Purchase, :count).by(-1)
    end

    it "redirects to the purchases list" do
      purchase = Purchase.create! valid_attributes
      delete :destroy, :id => purchase.to_param.to_s
      response.should redirect_to(purchases_url)
    end
  end

end
