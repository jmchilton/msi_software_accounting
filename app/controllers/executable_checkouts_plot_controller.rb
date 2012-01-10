class ExecutableCheckoutsPlotController < PlotController

  def index
    samples = @executable.sample_checkouts(plot_options)
    add_line_chart_data collect_chart_data(samples), "Checkouts"
  end

end