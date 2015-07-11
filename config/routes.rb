Rails.application.routes.draw do

  namespace :marriage, path: '/' do
    get '/' => 'marriage#show', as: :home

    resources :invites, only: [:index] do
      get :search, on: :collection
    end
  end
end
