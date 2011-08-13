module ApplicationHelper

  protected

  def show_report_form_tag
    form_tag(url_for({:action => :show_report})) do
      yield
    end
  end

end
