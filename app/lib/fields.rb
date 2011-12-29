
module Fields

  def group_name_field
    { :field => "group_name", :label => "Group Name" }
  end

  def checkouts_field
    {:field => "use_count", :label => "Checkouts", :search => false}
  end

  def executions_field
    {:field => "use_count", :label => "Executions", :search => false}
  end

  def loads_field
    {:field => "use_count", :label => "Loads", :search => false}
  end

  def username_field
    { :field => "username", :label => "Username"}
  end

  def first_name_field
    { :field => "first_name", :label => "First Name"}
  end

  def last_name_field
    { :field => "last_name", :label => "Last Name"}
  end

  def college_name_field
    { :field => "college_name", :label => "College" }
  end

  def email_field
    { :field => "email", :label => "E-Mail"}
  end

  def name_field
    { :field => "name", :label => "Name" }
  end

  def num_users_field
    { :field => "num_users", :label => "# Users", :search => false }
  end

  def num_groups_field
    { :field => "num_groups", :label => "# Groups", :search => false}
  end

  def id_field(name = "id")
    { :field => name, :label => "ID",  :resizable => false, :search => false, :hidden => true }
  end

  def fy_10_field
   fy_field(10)
  end

  def fy_11_field
    fy_field(11)
  end

  def fy_12_field
    fy_field(12)
  end

  def fy_13_field
    fy_field(13)
  end

  def fy_field(year)
    { :field => "fy"+year.to_s, :label => "Cost (FY 20#{year.to_s})", :search => false }
  end

  def link_field(options = {})
    options.reverse_merge({ :field => "link", :label => "View", :hidden => true, :link => true, :search => false})
  end

  def use_count_field(data_source)
    if data_source == :collectl
      TableController.executions_field
    elsif data_source == :flexlm
      TableController.checkouts_field
    elsif data_source == :module
      TableController.loads_field
    end
  end

  def resource_name_field
    { :field => "name", :label => "Resource", :search => true }
  end

  def resource_field
    { :field => "resource", :label => "Resource", :search => true }
  end

  def identifier_field
    { :field => "identifier", :label => "Feature", :search => true }
  end

  def vendor_field
    { :field => "comment", :label => "Vendor", :search => true }
  end

  def resources_fields(data_source)
    [id_field, resource_field, use_count_field(data_source), link_field(:link_proc => "resource_path")]
  end

  def executable_fields
    [id_field, identifier_field, vendor_field, resource_field, checkouts_field, link_field(:link_proc => "executable_path")]
  end

  def purchase_fields
    [{ :field => "num_packages", :label => "# Software Packages", :search => false},
      fy_10_field,
      fy_11_field,
      fy_12_field,
      fy_13_field]
  end

end