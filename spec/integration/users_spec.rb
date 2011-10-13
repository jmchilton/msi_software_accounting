require 'spec_helper'
require 'integration/integration_helpers'

describe "User navigation" do
  include IntegrationHelpers

  describe "show links" do
    before(:each) {
      @person = FactoryGirl.create(:person)
      @group = FactoryGirl.create(:group)
      @user = FactoryGirl.create(:user, :person => @person, :group => @group)
      visit "/users/#{@user.id}"
    }

    specify { it_should_have_msi_db_link_for(@user) }

    pending "should allow navigation to person" do
      page.find_link("person_link")[:href].should == person_path(@person)
    end

    pending "should allow navigation to group" do
      page.find_link("group_link")[:href].should == group_path(@group)
    end

  end

end