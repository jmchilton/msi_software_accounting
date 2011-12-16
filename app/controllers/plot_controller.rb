class PlotController < ApplicationController
  DEFAULT_CHART_ID="chart"

  protected

  def init_chart_data
    if @chart_data.blank?
      xaxis_options= {}
      unless from_date.blank?
        xaxis_options.merge! :min => from_date.to_time.to_i * 1000
      end

      unless to_date.blank?
        xaxis_options.merge! :max => to_date.to_time.to_i * 1000
      end

      @chart_data = TimeFlot.new(DEFAULT_CHART_ID) do |f|
        f.lines({:show => true, :fill => false, :steps => true})
        #f.legend({:container => '#flot_legend', :noColumns => 1 })
        #f.points
        f.xaxis xaxis_options.merge({:tickDecimals => false, :mode => :time, :minTickSize => [1, "day"]})
        f.yaxis :tickDecimals => false, :min => 0
        f.grid :hoverable => true
        f.selection :mode => "x"
      end
    end
  end

  def add_line_chart_data(data, label = nil, options = {})
    init_chart_data
    @chart_data.series(label, data, options)
  end


end