SoftwareWebApp::Application.routes.draw do

  resources :event_types
#, :except => [:new, :create, :delete]

  def add_report_to_controller(controller, prefix = "", with_id = false)
    match "#{controller}/#{prefix}report#{with_id ? '/:id' : ''}" => "#{controller}##{prefix}report", :as => "#{controller}_#{prefix}report".to_sym
    match "#{controller}/show_#{prefix}report#{with_id ? '/:id' : ''}(.:format)" => "#{controller}#show_#{prefix}report", :as => "#{controller}_show_#{prefix}report".to_sym
  end

  add_report_to_controller("resources")
  add_report_to_controller("colleges")

  resources :events, :only => [:index, :show]
  resources :executables
  resources :resources, :only => [:index, :show] do
    get :autocomplete_resource_name, :on => :collection
    resources :executable_user_report, :only => [:new, :index]
    resources :resource_user_report, :only => [:new, :index]
  end

  resources :colleges, :only => [:index, :show]
  resources :departments, :only => [:index, :show]
  resources :groups, :only => [:index, :show]
  resources :users, :only => [:index, :show]
  resources :people, :only => [:index, :show]
  resources :purchases

  get "home/index"

  root :to => "home#index"

end
