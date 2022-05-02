Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :pay_rates, only: %i[create update] do
    member do
      get :pay_amount
    end
  end
end
