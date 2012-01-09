

module ApplicationHelper

  protected

  def resource_name_field(value, options = {})
    autocomplete_field_tag "resource_name", value, autocomplete_resource_name_resources_path, options
  end

  def show_report_form_tag(action = 'index')
    form_tag(url_for({:action => action, :params => params}), :method => :get) do
      yield
    end
  end

  def use_jqgrid
    enable_javascript
  end

  def enable_javascript
    params[:enable_javascript] == "1"
  end

  def model_field(key, label, value)
    content_tag(:div, content_tag(:div, label, :class => "model_field_label") + content_tag(:div, value, :class => "model_field_value"),
                {:class =>"model_field", :id => "model_field_#{key}"})
  end


  def copy_email_addresses_link
    if use_jqgrid
      content_tag("script", "enable_copy_email_link();") +
        content_tag("div", content_tag("a", "Copy E-Mail Addresses to Clipboard", {:href => "#", :class => "report_link", :id => "d_clip_button"}),
                    {:id => "d_clip_container"})
    end
  end

  def model_link(name, options = {}, html_options = {})
    link_to(name, options, html_options.merge({:class => "model_link"}))
  end

  def data_source_summary_link(name, path, data_source)
    model_link(name, path, {:remote => true}) + content_tag("div", "", {:id =>  "#{data_source}-overview"})
  end

  def data_source
    if params[:data_source].blank?
      params[:data_source] = "flexlm"
    end
    data_source_sym = params[:data_source].to_sym
    if not [:flexlm, :collectl, :module].index(data_source_sym)
      raise ArgumentError, "Unknown data source type #{data_source_sym}"
    end
    data_source_sym
  end

  def report_type_title(data_source = data_source)
    {:collectl => "Collectl", :flexlm => "FLEXlm", :module => "Module Load" }[data_source]
  end


end
