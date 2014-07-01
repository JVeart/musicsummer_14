Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root 'landing#index'
  
  resources :votes, :only => [ :new, :create]
  resources :artists, :only => [ :show ] do
    member do
      post :vote
    end
  end
  
  resources :reports, :only => [ :new, :create]
  resources :contests, :only => [ :show ]
  
  get 'landing' => 'landing#index'
  
  get 'muzika' => 'music#index'
  get 'music' => 'music#index'
  get 'music/about' => 'music#about'
  get 'music/success' => 'music#success'
  get 'music/sign_in' => 'music#sign_in'
  
  get 'manifests' => 'manifest#index'
  get 'manifest' => 'manifest#index'
  get 'manifest/about' => 'manifest#about'
  get 'manifest/success' => 'manifest#success'
  get 'manifest/sign_in' => 'manifest#sign_in'
  
  get 'rules' => 'rules#index'
  get 'calendar' => 'calendar#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # 

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
