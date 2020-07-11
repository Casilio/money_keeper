Rails.application.routes.draw do
  root 'static_pages#index'

  devise_for :users
  resources :users
  resources :category
  resources :transactions

  get '/about', to: 'static_pages#about', as: 'about_page'
  get '/report/new', to: 'reports#new', as: 'new_report'
end

