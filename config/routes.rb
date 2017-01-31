Rails.application.routes.draw do

  root 'search#home'

  get 'home', to: "search#home", as: "home"
  # post '/search', to: "search#search", as: 'search'
end
