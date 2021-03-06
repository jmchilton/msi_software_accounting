class ExecutablesPlotController < PlotController

  def index
    max_samples = FlexlmAppSnapshot.sample_for_executable(@executable.exid, plot_options)
    add_line_chart_data collect_chart_data(max_samples, :total_licenses), "Available"

    add_line_chart_data collect_chart_data(max_samples), "Max in Use"
    if params[:sample] == "date"
      add_line_chart_data collect_chart_data(FlexlmAppSnapshot.sample_for_executable(params[:executable_id], plot_options.merge(:sample_with => "avg"))), "Average in Use"
    end

  end

end
