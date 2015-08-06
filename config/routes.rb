Rails.application.routes.draw do
  devise_for :admins
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  # root to: 'admin'
  root :to => redirect('/admin')

  resources :categories, only: [:index]
  resources :articles, only: [:index, :show]
end
