class CollectlExecutablesPlotController < PlotController
  include ReportHelper

  def new
    puts params[:collectl_executable_id]
    puts @collectl_executable
  end

  def index
    max_samples = CollectlExecution.sample_for_executable(@collectl_executable.id, plot_options)
    add_line_chart_data collect_chart_data(max_samples), "Max Running Executions"
    puts max_samples
  end

  private

  # TODO: Refactor, merge this with ExecutablesPlotController
  def plot_options
    report_options.merge({:sample => params[:sample], :sample_with => "max" })
  end

  def collect_chart_data(samples, field = :value)
    samples.collect { |sample| [sample[:for_date], sample[field]] }
  end

end