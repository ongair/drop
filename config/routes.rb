Rails.application.routes.draw do
  devise_for :admins
  devise_for :subscribers
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  # to be changed to drop landing page
  root :to => redirect('/admin')

  resources :categories, only: [:index]
  
  # Articles
  resources :articles, only: [:index, :show]
  post 'articles/:id/like' => 'articles#like', as: 'like_article' 
  post 'articles/search' => 'articles#search', as: 'search'

  # authentication endpoint
  post "/auth/sign_in" => "auth#log_in", :as => "sign_in"

  # preferences endpoints
  get "/auth/preferences", as: 'preferences'
  post "/auth/personalize"  
end
