module ReportHelper
  protected


  def model_type
    model_type = params[:model_type].to_sym
    raise ArgumentError unless [:user, :college, :group, :department].find model_type
    model_type
  end

  def model_type_title
    model_type.to_s.titleize
  end

  def report_options
    exclude_employees = !(params[:exclude_employees].blank? or params[:exclude_employees].to_i.zero?)
    limit_users_str = !(params[:limit_users].blank?) ? params[:limit_users] : nil
    if !limit_users_str.nil?
      limit_users_list = limit_users_str.split /[\s,;]+/
      limit_users_list = limit_users_list.select { |item| !item.strip.blank? }
    else
      limit_users_list = nil
    end
    {:from => params[:from],
     :to => params[:to],
     :exclude_employees => exclude_employees,
     :limit_users => limit_users_list,
     :data_source => data_source
    }
  end

  def render_report_zip(name = "reports")
    set_filename "#{name}.zip"
    render :template => '/reports.zip', :layout => false
  end

  def build_zip_for_resources report
    @zip_files = {}
    selected_resources.each do |resource|
      @zip_files[resource.name + ".csv"] = render_report_to_str report, resource
    end
  end

  def set_model_type
    @model_type = params[:model_type]
    raise(ArgumentError, "Unknown model_type #{@model_type}") unless ["user", "college", "group", "department"].index(@model_type)
  end

end