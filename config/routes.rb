Rails.application.routes.draw do

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # Root Route
  root 'static_pages#home'

  # Routes
  get    'about'                => 'static_pages#about'

  get    'chocolate-milk-ipsum' => 'ipsum#index'
  post   'chocolate-milk-ipsum' => 'ipsum#generate'

  get    'login'                => 'sessions#new'
  post   'login'                => 'sessions#create'
  delete 'logout'               => 'sessions#destroy'

  # Resource Routes (maps HTTP verbs to controller actions automatically):
  resources :users
  resources :reviews
  resources :recipes

end
