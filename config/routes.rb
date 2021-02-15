Rails.application.routes.draw do
  get 'users/show'
 root "homes#top"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  resources :users
  resources :books
  resources :homes
  get "home/about" => "homes#about"
end

