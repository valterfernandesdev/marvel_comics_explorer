Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "home#index"

  resources :home, only: :index
  resources :favourit_comics, only: :create do
    delete :destroy, on: :collection
  end
end
