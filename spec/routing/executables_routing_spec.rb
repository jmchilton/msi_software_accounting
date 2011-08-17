require "spec_helper"

describe ExecutablesController do
  describe "routing" do

    it "routes to #index" do
      get("/executables").should route_to("executables#index")
    end

    it "routes to #new" do
      get("/executables/new").should route_to("executables#new")
    end

    it "routes to #show" do
      get("/executables/1").should route_to("executables#show", :id => "1")
    end

    it "routes to #edit" do
      get("/executables/1/edit").should route_to("executables#edit", :id => "1")
    end

    it "routes to #create" do
      post("/executables").should route_to("executables#create")
    end

    it "routes to #update" do
      put("/executables/1").should route_to("executables#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/executables/1").should route_to("executables#destroy", :id => "1")
    end

  end
end
