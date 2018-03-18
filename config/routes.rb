Rails.application.routes.draw do
  apipie
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :users, only: [:index, :create, :show, :update, :destroy] do
        post 'sign_in', on: :collection
        post 'reconnect', on: :collection
        resources :follows, only: [:create] do
          delete '', on: :collection, action: :destroy
        end
      end

      resources :streams, only: [:index, :create, :show, :update, :destroy]
    end
  end
end
