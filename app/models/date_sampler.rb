module DateSampler

  def self.sample_date_expression(plot_options, date_expression)
    sample_by = plot_options[:sample]
    case sample_by
      when "date"
        expression = "DATE(#{date_expression})"
      else
        expression = "#{date_expression}"
    end
    expression
  end


end