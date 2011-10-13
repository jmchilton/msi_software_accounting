require 'spec_helper'

describe "groups/show.html.erb" do
  include ViewHelpers

  TEST_GROUP = "test_group"

  before(:each) do
    group = FactoryGirl.create(:group, :name => TEST_GROUP)
    @group = assign(:group, group)
    render
  end

  specify { it_should_have_title_text("Group #{TEST_GROUP}") }
  specify { it_should_have_model_field("name", "Name", TEST_GROUP) }

  specify { it_should_have_model_link "View Group on MSI DB", @group.msi_db_link }
  specify { it_should_have_model_link "Back to Group Index", groups_path  }

end