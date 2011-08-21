SoftwareWebApp::Application.routes.draw do

  resources :event_types
#, :except => [:new, :create, :delete]

  def add_report_to_controller(controller, prefix = "", with_id = false)
    match "#{controller}/#{prefix}report#{with_id ? '/:id' : ''}" => "#{controller}##{prefix}report", :as => "#{controller}_#{prefix}report".to_sym
    match "#{controller}/show_#{prefix}report#{with_id ? '/:id' : ''}(.:format)" => "#{controller}#show_#{prefix}report", :as => "#{controller}_show_#{prefix}report".to_sym
  end

  add_report_to_controller("resources")
  add_report_to_controller("resources", "usage_", true)
  add_report_to_controller("colleges")

  resources :events, :only => [:index, :show]
  resources :executables
  resources :resources, :only => [:index, :show] do
    get :autocomplete_resource_name, :on => :collection
    resources :executable_user_report, :only => [:new, :index]
  end

  resources :colleges, :only => [:index, :show]
  resources :departments, :only => [:index, :show]
  resources :groups, :only => [:index, :show]
  resources :users, :only => [:index, :show]
  resources :people, :only => [:index, :show]
  resources :purchases

  get "home/index"

  root :to => "home#index"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
