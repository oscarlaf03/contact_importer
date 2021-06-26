Rails.application.routes.draw do
  devise_for :users
  
  resources :users do
    resources :contacts, only: [:index]
    post 'import', to: 'contacts#import', as: 'import_contacts'
  end
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
