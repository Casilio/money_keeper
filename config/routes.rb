Rails.application.routes.draw do
  resources :transactions
    devise_for :users
	root "static_pages#index"

	get "/about", to: "static_pages#about"

	resources :users
	resources :category
	resources :transactions

	get '/report/new', to: "reports#new", as: "new_report"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
