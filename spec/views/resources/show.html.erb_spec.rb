require 'spec_helper'

describe "resources/show.html.erb" do
  include ViewHelpers

  before(:each) do
    resource = FactoryGirl.create(:resource, :name => "Gaussian", :short_name => "gaus", :description => "chemistry something or other", :documentation => "howto", :module => "gaus2011")
    @resource = assign(:resource, resource)
    render
  end

  specify { it_should_have_model_field("name", "Name", "Gaussian") }
  specify { it_should_have_model_field("short_name", "Short Name", "gaus") }
  specify { it_should_have_model_field("description", "Description", "chemistry something or other") }
  specify { it_should_have_model_field("documentation", "Documentation", "howto") }
  specify { it_should_have_model_field("module", "Module", "gaus2011") }

  specify { it_should_have_model_link "View Per User Usage Report", new_resource_resource_user_report_path(@resource.id) }
  specify { it_should_have_model_link "View Feature Report", new_resource_executables_report_path(@resource.id) }
  specify { it_should_have_model_link "View on MSI DB", @resource.msi_db_link }
  specify { it_should_have_model_link 'Back to Resources', resources_path  }

end