require 'spec_helper'

describe "resources/show.html.erb" do
  include ViewHelpers

  before(:each) do
    resource = FactoryGirl.create(:resource, :name => "Gaussian", :short_name => "gaus", :description => "chemistry something or other", :documentation => "howto", :module => "gaus2011")
    @resource = assign(:resource, resource)
    render
  end

  specify { it_should_have_title_text("Resource Gaussian") }
  specify { it_should_have_model_field("name", "Name", "Gaussian") }
  specify { it_should_have_model_field("short_name", "Short Name", "gaus") }
  specify { it_should_have_model_field("description", "Description", "chemistry something or other") }
  specify { it_should_have_model_field("documentation", "Documentation", "howto") }
  specify { it_should_have_model_field("module", "Module", "gaus2011") }

  specify { it_should_have_model_link "Build Per User FLEXlm Usage Report", new_resource_resource_model_report_path(@resource.id, :model_type => :user) }
  specify { it_should_have_model_link "Build FLEXlm Feature Report", new_resource_executables_report_path(@resource.id) }
  specify { it_should_have_model_link "Manage Collectl Executables", resource_mappables_path(:resource_id => @resource.id, :mappable_type =>"collectl_executable") }
  specify { it_should_have_model_link "Manage Modules", resource_mappables_path(:resource_id => @resource.id, :mappable_type =>"module") }
  specify { it_should_have_model_link "View on MSI DB", @resource.msi_db_link }
  specify { it_should_have_model_link "Back to Resource Index", resources_path  }

end