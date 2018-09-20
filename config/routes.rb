Rails.application.routes.draw do
  resources :urls, only: [:index, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'urls#index'
  get '/:slug', to: 'urls#navigate'
  get '/a/:slug', to: 'admin#show'
  patch '/a/:slug', to: 'admin#update'
end
