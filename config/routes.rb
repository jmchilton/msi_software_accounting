  SoftwareWebApp::Application.routes.draw do

  def report_resources(name)
    resources name, :only => [:new, :index]
  end

  def readonly_resources(name)
    resources name, :only => [:show, :index] do
      yield if block_given?
    end
  end

  report_resources :colleges_report
  report_resources :departments_report
  report_resources :groups_report
  report_resources :resources_report

  resources :event_types, :only => [:index, :show, :update, :edit]

  resources :executables do 
    report_resources :executables_plot
    report_resources :executable_user_report
    report_resources :executable_group_report
    report_resources :executable_department_report
    report_resources :executable_college_report
  end

  resources :purchases

  readonly_resources :resources do
    get :autocomplete_resource_name, :on => :collection

    resources :collectl_executables

    report_resources :executables_report
    report_resources :resource_user_report
    report_resources :resource_group_report
    report_resources :resource_department_report
    report_resources :resource_college_report

  end

  readonly_resources :events
  readonly_resources :people

  readonly_resources :colleges do
    report_resources :college_executables_report
    report_resources :college_resources_report
  end

  readonly_resources :departments do
    report_resources :department_executables_report
    report_resources :department_resources_report
  end

  readonly_resources :groups do
    report_resources :group_executables_report
    report_resources :group_resources_report
  end

  readonly_resources :users do
    report_resources :user_executables_report
    report_resources :user_resources_report
  end

  report_resources :batch_resource_group_report
  report_resources :batch_resource_department_report
  report_resources :batch_resource_user_report
  report_resources :batch_resource_college_report

  get "home/index"
  get "home/news"

  root :to => "home#index"


end
