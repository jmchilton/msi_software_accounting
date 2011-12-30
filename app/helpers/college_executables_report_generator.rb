module CollegeExecutablesReportGenerator
  include ModelExecutablesReportGenerator

  protected

  def college_executables_report
    executables_report_for_model(:college)
  end

end