Rails.application.routes.draw do
  mount Attachinary::Engine => "/attachinary"
  root to: 'pages#home'

  resources :spaces do
    resources :bookings
  end

  resources :cars

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


end
