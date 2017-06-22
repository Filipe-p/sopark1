Rails.application.routes.draw do
  mount Attachinary::Engine => "/attachinary"
  root to: 'pages#home'

  resources :spaces do
    resources :reviews
    resources :bookings do
      resources :payments
    end
  end

  resources :cars

  devise_for :users,
  controllers: { omniauth_callbacks: 'users/omniauth_callbacks'}

end
