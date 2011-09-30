class ReportController < ApplicationController
  before_filter :set_last_date_range

  protected

  def respond_with_report
    respond_with_table(false)
  end

  def report_options
    {:from => params[:from], :to => params[:to]}
  end

  private

  def set_last_date_range
    if not params[:from].nil?
      session[:last_from] = params[:from]
    end

    if not params[:to].nil?
      session[:last_to] = params[:to]
    end

  end


end