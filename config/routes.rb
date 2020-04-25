Rails.application.routes.draw do
  root 'user#index'
  get 'user/index'
  post 'signup', to: 'user#signup'
  patch 'user/profile/:id', to: 'user#update_user'
  get 'mentors', to: 'mentors#mentors'
  get 'courses', to: 'courses#courses'
  get 'profile', to: 'profile#show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
