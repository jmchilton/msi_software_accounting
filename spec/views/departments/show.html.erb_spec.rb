require 'spec_helper'

describe "departments/show.html.erb" do
  include ViewHelpers

  TEST_DEPT_NAME = "test_user"

  before(:each) do
    department = FactoryGirl.create(:department, :name => TEST_DEPT_NAME)
    @department = assign(:user, department)
    render
  end

  specify { it_should_have_title_text("Department #{TEST_DEPT_NAME}") }
  specify { it_should_have_model_field("name", "Name", TEST_DEPT_NAME) }

  specify { it_should_have_model_link "View Department on MSI DB", @department.msi_db_link }
  specify { it_should_have_model_link "Back to Department Index", departments_path  }

end