Rails.application.routes.draw do

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # Root Route
  root 'home#index'

  # Post Routes
  get    'about'       => 'about#index'
  get    'login'       => 'sessions#new'
  post   'login'       => 'sessions#create'
  delete 'logout'      => 'sessions#destroy'

  # Resource Routes (maps HTTP verbs to controller actions automatically):
  resources :users
  resources :reviews
  resources :recipes

end
