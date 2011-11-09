class ExecutablesPlotController < TableController
  include ReportHelper

  def new
  end

  def index
    max_samples = FlexlmAppSnapshot.sample_for_executable(@executable.exid, plot_options)
    add_line_chart_data collect_chart_data(max_samples, :total_licenses), "Available"

    add_line_chart_data collect_chart_data(max_samples), "Max in Use"
    if params[:sample] == "date"
      add_line_chart_data collect_chart_data(FlexlmAppSnapshot.sample_for_executable(params[:executable_id], plot_options.merge(:sample_with => "avg"))), "Average in Use"
    end

  end

  private

  def plot_options
    report_options.merge({:sample => params[:sample], :sample_with => "max" })
  end

  def collect_chart_data(samples, field = :value)
    samples.collect { |sample| [sample[:for_date], sample[field]] }
  end



end
