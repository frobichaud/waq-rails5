Rails.application.routes.draw do
  get '/', controller: :home, action: :index

  get 'sales/index'

  mount ActionCable.server => '/cable'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
