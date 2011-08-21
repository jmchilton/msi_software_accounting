class ReportController < ApplicationController
  def respond_with_report
    respond_with_table(false)
  end

  def report_options
    {:from => params[:from], :to => params[:to]}
  end
end