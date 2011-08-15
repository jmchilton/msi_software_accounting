module ApplicationHelper

  protected

  def show_report_form_tag(action = :show_report)
    form_tag(url_for({:action => action})) do
      yield
    end
  end

end
