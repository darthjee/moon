Rails.application.routes.draw do
  get '/' => 'marriage#show', as: :home
end
