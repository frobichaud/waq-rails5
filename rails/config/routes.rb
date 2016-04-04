Rails.application.routes.draw do
  get 'sales/index'

  mount ActionCable.server => '/sales_cable'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
