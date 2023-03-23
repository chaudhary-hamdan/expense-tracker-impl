Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  # root 'welcome#index'

  # resources :admin
  # resources :users

  resources :employees
  resources :expense_reports
  resources :expenses
  resources :comments



end
