module ApplicationHelper
  @@fiscal_years = (10..13).map { |year| "fy#{year}"}

  protected
  def fiscal_years
    @@fiscal_years
  end

end
