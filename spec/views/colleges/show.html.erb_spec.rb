require 'spec_helper'

describe "colleges/show.html.erb" do
  include ViewHelpers

  TEST_COLLEGE_NAME = "uofm"

  before(:each) do
    college = FactoryGirl.create(:college, :name => TEST_COLLEGE_NAME)
    @college = assign(:college, college)
    render
  end

  specify { it_should_have_title_text("College #{TEST_COLLEGE_NAME}") }
  specify { it_should_have_model_field("name", "Name", TEST_COLLEGE_NAME) }

  specify { it_should_have_model_link "View College on MSI DB", @college.msi_db_link }
  specify { it_should_have_model_link "Back to College Index", colleges_path  }

end