Rails.application.routes.draw do
  devise_for :users
  # get 'patients/index'
  # post 'patients/update'

  resources :patients
  
  root to: 'patients#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
