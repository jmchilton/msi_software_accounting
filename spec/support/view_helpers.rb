require 'time_flot'
require 'support/page_helpers'

module ViewHelpers
  include PageHelpers

  def page
    Capybara::Node::Simple.new(rendered)
  end

  def render_mock(type)
    object = assign(type, FactoryGirl.create(type))
    path_parameters["#{type}_id".to_sym] = object.id
    render
  end

  def setup_test_chart_data
    chart_data = TimeFlot.new(PlotController::DEFAULT_CHART_ID) do |f|
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


  def it_should_render_plot_options(optional_args = {})
    it_should_render_date_options
  end

  def it_should_render_a_chart
    rendered.should match /.*chart_data.*/
    page.find_link("Back to Chart Options")[:href].ends_with?("/new").should be_true
  end

end