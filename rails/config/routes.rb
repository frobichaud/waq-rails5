Rails.application.routes.draw do
  get 'sales/index'

  mount ActionCable.server => '/sales_cable'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
