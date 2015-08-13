Rails.application.routes.draw do

  namespace :marriage, path: '/' do
    get '/' => 'marriage#show', as: :home

    resources :guests, path: '/convidados', only: [:index, :show] do
      get :search, on: :collection, defaults: { format: :json }
    end

    resources :invites, path: '/convites', only: [:update], defaults: { format: :json } do
      get ':code' => :show, on: :collection, defaults: { format: :html }
    end
  end
end
