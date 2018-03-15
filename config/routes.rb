Rails.application.routes.draw do
  apipie
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :users, only: [:index, :create, :show, :update, :destroy] do
        post 'sign_in', on: :collection
        post 'reconnect', on: :collection
      end

      resources :streams, only: [:index, :create, :show, :update, :destroy] do
        resources :follows, only: [:create, :destroy]
      end
    end
  end
end
