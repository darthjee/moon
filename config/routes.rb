Rails.application.routes.draw do

  namespace :marriage, path: '/' do
    get '/' => 'marriage#show', as: :home

    resources :guests, path: '/convidados', only: [:index] do
      get :search, on: :collection, defaults: { format: :json }
    end

    resources :invites, path: '/convites', only: [:update], defaults: { format: :json } do
      get ':code' => :show, on: :collection, defaults: { format: :html }
      get 'for_guest/:guest_id' => :show, on: :collection, defaults: { format: :html }
    end
  end
end
