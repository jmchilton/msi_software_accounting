SoftwareWebApp::Application.routes.draw do

  def report_resources(name)
    resources name, :only => [:new, :index]
  end

  def readonly_resources(name)
    resources name, :only => [:show, :index] do
      yield if block_given?
    end
  end

  report_resources :batch_resource_report
  report_resources :model_resources_report
  report_resources :model_executables_report

  report_resources :colleges_report
  report_resources :departments_report
  report_resources :groups_report
  report_resources :resources_report

  resources :event_types, :only => [:index, :show, :update, :edit]

  resources :executables do 
    report_resources :executables_plot
    report_resources :executable_checkouts_plot
    report_resources :executable_model_report
  end

  # Route overview controllers
  ["executable", "collectl_executable", "module", "resources"].each do |data_type|
    resources "#{data_type}_overview".to_sym, :only => [:show]
  end

  resources :module_loads, :only => [:create]
  resources :modules
  resources :purchases

  resources :collectl_executables do
    report_resources :collectl_executables_plot
  end

  resources :resource_mappables

  readonly_resources :resources do
    get :autocomplete_resource_name, :on => :collection

    report_resources :executables_report
    report_resources :resource_model_report
  end

  readonly_resources :events
  readonly_resources :people

  readonly_resources :colleges do
  end

  readonly_resources :departments do
  end

  readonly_resources :groups do
  end

  readonly_resources :users do
  end


  get "home/index"
  get "home/news"

  root :to => "home#index"


end
