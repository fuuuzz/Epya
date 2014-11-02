Rails.application.routes.draw do

  # HOMEPAGE
  root 'welcome#hello'

  # RESSOURCES
  devise_for :users
  resources  :projects do
    member do
      get 'news_tab'
      get 'comment_tab'
      get 'show_project_tab'
      get 'unfollow'
      get 'destroy_tag'
      get 'destroy_photo'
    end
  end
  resources  :users do
    member do
      get 'destroy_avatar'
    end
  end
  resources  :comments
  resources  :news
  resources :tags
  
  #SPECIFIQUES
  get 'projects/:id/follow' => 'projects#follow', as: :follow
  get 'faq'  => 'welcome#faq'
  get 'team' => 'welcome#team'
  get 'idea' => 'welcome#idea'
  get 'terms-of-use' => 'welcome#terms'
  post 'search' => 'tags#search', a: :search

end