Rails.application.routes.draw do

  namespace :marriage, path: '/' do
    get '/' => 'marriage#show', as: :home

    resources :guests, path: '/convidados', only: [:index] do
      get :search, on: :collection, defaults: { format: :json }
    end

    resources :best_man, path: '/padrinhos', only: [:index] do
      scope defaults: { format: :html } do
        get ':code' => :show, on: :collection, as: :show
      end
    end

    resources :login, path: '/login', only: [:create], defaults: { format: :json } do
      scope defaults: { format: :html } do
        get '/' => :index, on: :collection, as: :index
      end
    end

    resources :invites, path: '/convites', only: [:update], defaults: { format: :json } do
      scope defaults: { format: :html } do
        get 'cards' => :cards, on: :collection, as: :cards
        get ':code' => :show, on: :collection, as: :show
        get 'for_guest/:guest_id' => :show, on: :collection
      end
    end
  end
end
