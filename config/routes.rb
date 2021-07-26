Rails.application.routes.draw do
  devise_for :users
  # get 'patients/index'
  # post 'patients/update'

  resources :patients do 
    collection do
      get :submit_success
      get :get_date
      get :fetch_records
    end
  end
  
  resources :admins
  
  root to: 'patients#fetch_records'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
