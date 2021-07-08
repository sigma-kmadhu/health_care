Rails.application.routes.draw do
  devise_for :users
  # get 'patients/index'
  # post 'patients/update'

  resources :patients do 
    collection do
      get :submit_success
      get :get_date
      get :get_calender
    end
  end
  
  resources :admins
  
  root to: 'patients#get_calender'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
