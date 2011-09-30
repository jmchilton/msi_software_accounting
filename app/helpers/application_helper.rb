

module ApplicationHelper

  protected

  def resource_name_field(value)
    autocomplete_field_tag "resource_name", value, autocomplete_resource_name_resources_path
  end

  def show_report_form_tag(action)
    form_tag(url_for({:action => action}), :class => "bp", :method => :get) do
      yield
    end
  end

  def use_jqgrid
    params[:enable_javascript] == "1"
  end

  def model_field(key, label, value)
    content_tag(:div, content_tag(:div, label, :class => "model_field_label") + content_tag(:div, value, :class => "model_field_value"),
                {:class =>"model_field", :id => "model_field_#{key}"})
  end

end
