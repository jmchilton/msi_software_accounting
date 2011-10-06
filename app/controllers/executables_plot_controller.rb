class ExecutablesPlotController < ReportController
  def new
  end

  def plot_options
    report_options.merge({:sample => params[:sample], :sample_with => params[:sample_with] })
  end

  def index
    samples = FlexlmAppSnapshot.sample_for_executable(params[:executable_id], plot_options)
    used_data = samples.collect { |sample| [sample.for_date, sample.value] }
    total_data = samples.collect { |sample|  [sample.for_date, sample.total_licenses] }
    set_line_chart_data([total_data, used_data])
  end

end
