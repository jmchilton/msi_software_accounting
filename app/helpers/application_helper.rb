module ApplicationHelper

  protected

  def show_report_form_tag(action)
    form_tag(url_for({:action => action}), :class => "bp") do
      yield
    end
  end

  def use_jqgrid
    params[:enable_javascript] == "1"
  end


end
