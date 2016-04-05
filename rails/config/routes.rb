Rails.application.routes.draw do
  get '/', controller: :home, action: :index

  resources :sales, only: [:index, :create]

  mount ActionCable.server => '/cable'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
