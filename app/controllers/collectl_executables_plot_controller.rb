class CollectlExecutablesPlotController < PlotController

  def index
    max_samples = CollectlExecution.sample_for_executable(@collectl_executable.id, plot_options)
    add_line_chart_data collect_chart_data(max_samples), "Max Running Executions"
    puts max_samples
  end

end