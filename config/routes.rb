Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :products, only: [:index, :show]
    resource :users, only: :create
    resource :sessions, only: [:create, :destroy]
    resource :line_items, only: [:create]
  end
end
