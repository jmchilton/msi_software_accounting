module ReportHelper
  protected

  def report_type_title
    report_options[:data_source] == :collectl ? "Collectl" : "FLEXlm"
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

  def data_source
    data_source = :flexlm
    if (!params[:data_source].blank?) and params[:data_source] == "collectl"
      data_source = :collectl
    end
    data_source
  end



  def render_report_zip(name = "reports")
    set_filename "#{name}.zip"
    render :template => '/reports.zip', :layout => false
  end

  def build_zip_for_resources report
    @zip_files = {}
    selected_resources.each do |resource|
      @zip_files[resource.name] = render_report_to_str report, resource
    end
  end

end