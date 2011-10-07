require 'time_flot'

module ViewHelpers

  def page
    Capybara::Node::Simple.new(rendered)
  end

  def it_should_have_model_field(field, title, value)
    page.find("div#model_field_#{field} > div.model_field_label").should have_content(title)
    page.find("div#model_field_#{field} > div.model_field_value").should have_content(value)
  end

  def it_should_have_model_link(title, to)
    page.find(:xpath, "//a[@href='#{to}' and @class='model_link']").should have_content(title)
  end

  def setup_test_chart_data
    chart_data = TimeFlot.new(ApplicationController::DEFAULT_CHART_ID) do |f|
      f.lines
      f.points
      f.xaxis :tickDecimals => false, :mode => :time, :minTickSize => [1, "day"]
      f.yaxis :tickDecimals => false, :min => 0
      f.grid :hoverable => true
      f.selection :mode => "xy"
    end
    chart_data.series(nil, [[1.day.ago, 1], [2.days.ago, 3]])
    assign(:chart_data, chart_data)
  end

  def path_parameters
    controller.request.path_parameters
  end


  def it_should_render_report_options
    page.find("input[name=from]").should_not be_nil
    page.find("input[name=to]").should_not be_nil
  end

  def it_should_render_a_chart
    rendered.should match /.*chart_data.*/
    page.find_link("Back to Chart Options")[:href].ends_with?("/new").should be_true
  end

end