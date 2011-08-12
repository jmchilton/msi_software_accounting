require "spec_helper"

describe EventTypesController do
  describe "routing" do

    it "routes to #index" do
      get("/event_types").should route_to("event_types#index")
    end

    it "routes to #show" do
      get("/event_types/1").should route_to("event_types#show", :id => "1")
    end

    it "routes to #edit" do
      get("/event_types/1/edit").should route_to("event_types#edit", :id => "1")
    end


    it "routes to #update" do
      put("/event_types/1").should route_to("event_types#update", :id => "1")
    end


  end
end
