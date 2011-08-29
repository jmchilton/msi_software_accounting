require 'spec_helper'
require 'controllers/table_helpers'
describe EventTypesController do
  include TableHelpers

  before(:each) {
    @resource = FactoryGirl.create(:resource)
    @resource_name = @resource.name
    @event_type = EventType.new valid_attributes
    EventType.stub!(:find).with("1").and_return(@event_type)
  }

  def valid_attributes
    {:id => 1, :feature => "Feature", :vendor => "Vendor", :resource_name => @resource_name }
  end

  describe "GET index" do
    before(:each) {
      EventType.stub!(:all).and_return([@event_type])
      get :index
    }

    it "assigns all event_types as @event_types" do
      assigns(:event_types).should eq([@event_type])
    end
``
    specify { it_should_respond_successfully_with_paginating_table }
  end

  describe "GET show" do

    it "assigns the requested event_type as @event_type" do
      get :show, :id => @event_type.id.to_s
      assigns(:event_type).should eq(@event_type)
    end

  end

  describe "GET edit" do

    it "assigns the requested event_type as @event_type" do
      get :edit, :id => @event_type.id.to_s
      assigns(:event_type).should eq(@event_type)
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      before(:each) { @event_type.should_receive(:update_resource).with(@resource_name).and_return(true) }

      it "assigns the requested event_type as @event_type" do
        put :update, :id => @event_type.id.to_s, :resource_name => @resource_name
        assigns(:event_type).should eq(@event_type)
      end

      it "redirects to the event_type" do
        put :update, :id => @event_type.id.to_s, :resource_name => @resource_name
        response.should redirect_to(:action => 'index')
      end

    end

    describe "with invalid params" do
      before(:each) { EventType.any_instance.stub(:update_resource).with(@resource_name).and_return(false) }

      it "assigns the event_type as @event_type" do
        # Trigger the behavior that occurs when invalid params are submitted
        put :update, :id => @event_type.id.to_s, :resource_name =>  @resource_name
        assigns(:event_type).should eq(@event_type)
      end

      it "re-renders the 'edit' template" do
        put :update, :id => @event_type.id.to_s, :resource_name => @resource_name
        response.should render_template("edit")
      end

    end

  end

end
