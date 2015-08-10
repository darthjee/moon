Rails.application.routes.draw do

  namespace :marriage, path: '/' do
    get '/' => 'marriage#show', as: :home

    resources :guests, only: [:index, :show] do
      get :search, on: :collection, defaults: { format: :json }
    end

    resources :invites, only: [:update], defaults: { format: :json }
  end
end
