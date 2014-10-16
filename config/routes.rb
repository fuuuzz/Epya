Rails.application.routes.draw do


  # HOMEPAGE
  root 'welcome#hello'

  # RESSOURCES
  devise_for :users
  resources  :projects do
    member do
      get 'new_tab'
      get 'comment_tab'
      get 'show_tab'
      get 'unfollow'
    end
  end
  resources  :users
  resources  :comments
  resources  :news
  
  #SPECIFIQUES
  get 'projects/:id/follow' => 'projects#follow', as: :follow

end
