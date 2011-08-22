module ApplicationHelper

  protected

  def show_report_form_tag(action)
    form_tag(url_for({:action => action}), :class => "bp", :method => :get) do
      yield
    end
  end

  def use_jqgrid
    params[:enable_javascript] == "1"
  end


end
