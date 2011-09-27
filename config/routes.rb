SoftwareWebApp::Application.routes.draw do

  def report_resources(name)
    resources name, :only => [:new, :index]
  end

  def readonly_resources(name)
    resources name, :only => [:show, :index]
  end

  report_resources :colleges_report
  report_resources :resources_report

  resources :event_types, :only => [:index, :show, :update, :edit]
  resources :executables

  resources :purchases

  resources :resources, :only => [:index, :show] do
    get :autocomplete_resource_name, :on => :collection
    report_resources :executables_report
    report_resources :resource_user_report


  end

  readonly_resources :events
  readonly_resources :colleges
  readonly_resources :departments
  readonly_resources :groups
  readonly_resources :users
  readonly_resources :people

  get "home/index"
  get "home/flot_test"

  root :to => "home#index"

end