

module ApplicationHelper

  protected


  def resource_name_field(value)
    autocomplete_field_tag "resource_name", value, autocomplete_resource_name_resources_path
  end

  def show_report_form_tag(action = 'index')
    form_tag(url_for({:action => action}), :class => "bp", :method => :get) do
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

  def cell_value(field, row)
    if field[:link]
      link_to "View", instance_eval("#{field[:link_proc]}(row)")
    else
      field_key = field[:field]
      if field_key.is_a?(Proc)
        field_key.call(row)
      else
        row[field_key.to_sym]
      end
    end
  end

  def clean_fields(fields)
    fields.collect do |hash|
      hash_copy = hash.clone
      hash_copy.delete :link_proc
      hash_copy
    end
  end

end
