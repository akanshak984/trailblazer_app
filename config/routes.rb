Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [] do
    collection do
      post 'sign_up'
      post 'sign_in'
    end
  end
end
