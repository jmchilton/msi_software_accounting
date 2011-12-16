

module ApplicationHelper

  protected

  def resource_name_field(value, options = {})
    autocomplete_field_tag "resource_name", value, autocomplete_resource_name_resources_path, options
  end

  def show_report_form_tag(action = 'index')
    form_tag(url_for({:action => action}), :method => :get) do
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


end
