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
      get '/padrinhos/lista' => :list_honors, as: :list_honors, defaults: { format: :html }
      patch '/padrinhos/:id' => :update, as: :update_best_men
    end

    resources :login, path: '/login', only: [:create], defaults: { format: :json } do
      get '/check' => :check, on: :collection, as: :check
      get '/usuario' => :show, on: :collection, as: :show

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

    resources :gifts, path: '/presentes', only: [:index, :show], defaults: { format: :html } do
      get '/pagina/:page' => :index, on: :collection, as: :paginated

      resources :gift_links, path: '/descricao', only: [:show]
    end

    resource :passwords, path: '/senha', only: [:create], defaults: { format: :json } do
      post '/atualizar' => :update, as: :update

      scope defaults: { format: :html }, on: :collection do
        get '/recuperar' => :recovery, as: :recovery
        get  '/:code' => :edit, as: :edit
      end
    end

    resources :albums, path: '/album/', only: [:index], defaults: { format: :html } do
      get '/pagina/:page' => :index, on: :collection, as: :paginated

      resources :pictures, path: '/fotos', only: [:index] do
        get '/pagina/:page' => :index, on: :collection, as: :paginated
      end
    end

    resources :events, path: '/eventos/', only: [], defaults: { format: :json } do
      get '/mapas' => :maps, on: :collection, as: :maps, defaults: { format: :html }
    end
  end

  namespace :comment, path: '/', defaults: { format: :json } do
    resources :threads, only: [] do
      resources :comments, only: [:index, :create]
    end
  end

  namespace :admin, path: '/admin', defaults: { format: :json } do
    resources :login, path: '/login', only: [:index], defaults: { format: :html } do
      get :forbidden, on: :collection, as: :forbidden
      get '/check' => :check, on: :collection, as: :check
    end

    namespace :marriage, path: '/' do
      resources :gifts, path: '/presentes', only: [:create, :update]

      resources :albums, path: '/album/', only: [] do
        resources :pictures, path: '/fotos', only: [:update]
      end
    end
  end
end
