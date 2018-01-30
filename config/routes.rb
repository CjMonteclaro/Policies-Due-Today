Rails.application.routes.draw do

  devise_for :users, path: :sessions
  resources :users

  resources :travels do
    get 'search', on: :collection
  end

  resources :roles
  resources :ranks
  resources :approvals
  resources :profiles
  # devise_for :accounts
  resources :policy_resolutions
  # devise_for :users
  # resources :users
  match 'travel_search', to: 'policies#travel_declarations', via: :get
  match 'motors_search', to: 'policies#motor_declarations', via: :get


    # get 'policies/motor_declarations'
    #
    # get 'policies/travel_declarations'

  resources :policies do
    collection { get :due_today }
    collection { get :motor_declarations }
    collection { get :travel_declarations }
  end

  root to: 'users#new'

end
