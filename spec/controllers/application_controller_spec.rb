require 'spec_helper'

class TestApplicationController < ApplicationController
end

describe ApplicationController do
  describe "with_pagination_and_ordering" do
    let(:app) { 
      TestApplicationController.new()
    }
    let(:sorted_users) { 
      app.send(:with_pagination_and_ordering, User).all
    }
    let(:alice_idx) { 
      sorted_users.index(&with_username("alice"))
    }
    let(:shelly_idx) {
      sorted_users.index(&with_username("shelly"))
    }
    def with_username(username) 
      lambda { |user| user.username == username }
    end

    it "should order properly, ascending by default" do
      app.params = { :sidx => "username" }
      alice_idx.should be < shelly_idx
    end

    it "should order properly when given direction" do
      app.params = { :sidx => "username", :sord => "DESC" }
      alice_idx.should be > shelly_idx
    end

  end
end
