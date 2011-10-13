require 'spec_helper'

describe "users/show.html.erb" do
  include ViewHelpers

  TEST_USERNAME = "test_user"

  before(:each) do
    user = FactoryGirl.create(:user, :username => TEST_USERNAME)
    @user = assign(:user, user)
    render
  end

  specify { it_should_have_title_text("User #{TEST_USERNAME}") }
  specify { it_should_have_model_field("username", "Username", TEST_USERNAME) }

  specify { it_should_have_model_link "View User on MSI DB", @user.msi_db_link }
  specify { it_should_have_model_link "Back to User Index", users_path  }

end