Rails.application.routes.draw do
  resources :urls
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'urls#index'
  get '/:slug', to: 'urls#navigate'
end
