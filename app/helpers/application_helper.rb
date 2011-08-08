module ApplicationHelper
  @@fiscal_years = (10..13).map { |year| "fy#{year}"}


  protected

  def show_report_form_tag
    form_tag(url_for({:action => :show_report, :no_javascript => "1"})) do
      yield
    end
  end


  def fiscal_years
    @@fiscal_years
  end

end
