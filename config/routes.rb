Rails.application.routes.draw do

  namespace :marriage, path: '/' do
    get '/' => 'marriage#show', as: :home

    resources :guests, path: '/convidados', only: [:index] do
      get :search, on: :collection, defaults: { format: :json }
    end

    resources :best_man, path: '/padrinhos/informativo', only: [:index] do
      scope defaults: { format: :html } do
        get ':code' => :show, on: :collection, as: :show
      end
    end

    scope path: '/', defaults: { format: :json }, controller: :best_man do
      get '/madrinhas' => :show_maids, as: :show_maids, defaults: { role: :maid_honor }
      get '/padrinhos' => :show_maids, as: :show_best_men, defaults: { role: :best_man }
      get '/maes' => :show_maids, as: :show_mothers, defaults: { role: :mother }
      patch '/padrinhos/:id' => :update, as: :update_best_men
    end

    resources :login, path: '/login', only: [:create], defaults: { format: :json } do
      get '/check' => :check, on: :collection, as: :check

      scope defaults: { format: :html } do
        get '/' => :index, on: :collection, as: :index
      end
    end

    resources :invites, path: '/convites', only: [:update], defaults: { format: :json } do
      scope defaults: { format: :html } do
        get 'cards' => :cards, on: :collection, as: :cards, defaults: { page: 1 }
        get 'cards/:page' => :cards, on: :collection, as: :paged_cards
        get ':code' => :show, on: :collection, as: :show
        get 'for_guest/:guest_id' => :show, on: :collection
      end
    end

    resources :gifts, path: '/presentes', only: [:index, :create], defaults: { format: :html } do
      get '/page/:page' => :index, on: :collection, as: :paginated
    end
  end
end
