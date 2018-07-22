Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :products, only: [:index, :show]
    resource :users, only: :create
    resource :sessions, only: [:create, :destroy]
    resources :line_items, only: [:index, :create]
  end
end
