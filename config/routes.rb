Rails.application.routes.draw do
  root "home#index"

  post "/", to: "home#login"
  get "logout", to: "home#logout", as: "logout"

  get "time_zone", to: "home#time_zone"

  get "consumers", to: "consumer#index", as: "consumers"
  get "consumer/:uuid", to: "consumer#show", as: "consumer"
end
