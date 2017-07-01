Rails.application.routes.draw do

  mount Attachinary::Engine => "/attachinary"
  root to: 'pages#home'

  resources :spaces do
    resources :reviews
    resources :bookings do
      resources :payments
    end
  end

  resources :space_dashboards, :booking_dashboards, :cars

  # resources :bookings, only: [:index]

  devise_for :users,
  controllers: { omniauth_callbacks: 'users/omniauth_callbacks', confirmations: 'confirmations'}

end
