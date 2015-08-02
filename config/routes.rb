Rails.application.routes.draw do

  namespace :marriage, path: '/' do
    get '/' => 'marriage#show', as: :home

    resources :guests, only: [:index, :show] do
      get :search, on: :collection
    end

    resources :invites, only: [:update]
  end
end
