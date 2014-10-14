Rails.application.routes.draw do

  # HOMEPAGE
  root 'projects#index'

  # RESSOURCES
  devise_for :users
  resources  :projects do
    member do
      get 'actu_tab'
      get 'comment_tab'
      get 'show_tab'
    end
  end
  resources  :users
  resources  :comments
  resources :projects do
     resources :comments
   end
  
  #SPECIFIQUES
  get 'projects/:id/follow' => 'projects#follow', as: :follow

end
