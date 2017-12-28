Rails.application.routes.draw do
  resources :roles
  resources :ranks
  resources :approvals
  devise_for :users, path: :sessions


# get 'users/new'
# post 'users/new'
  # authenticated :user do

    resources :users
    resources :profiles
    # devise_for :accounts
      resources :policy_resolutions
    # devise_for :users
    # resources :users
    get 'policies/motor_declarations'

    get 'policies/travel_declarations'

    get 'policies/index'

    get 'policies/show'

    get 'policies/new'

    post 'policies/create'

    get 'policies/due_today'

    get 'policies/motor_declation'

    get 'policies/travel_declaration'

    get 'policies/details'

    # # root to: 'profiles#index'
    # authenticated :user do
    #   root to: 'policies#due_today'
    # end
    # root to: redirect('credentials/sign_in')
      root to: 'users#new' #, as: :authenticated_root

end
