Rails.application.routes.draw do
  get 'search/search'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'search#home'
  post '/search', to: "search#search", as: 'search'
end
