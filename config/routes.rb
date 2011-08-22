SoftwareWebApp::Application.routes.draw do

  resources :event_types
#, :except => [:new, :create, :delete]

  resources :colleges_report, :only => [:new, :index]
  resources :resources_report, :only => [:new, :index]

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
