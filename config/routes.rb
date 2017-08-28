Rails.application.routes.draw do
  devise_for :users
	root "static_pages#index"

	get "/about", to: "static_pages#about"

	resources :users do
		member do
			get :income, :expose
		end
	end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
