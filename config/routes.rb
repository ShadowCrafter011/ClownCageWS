Rails.application.routes.draw do
  root "home#index"

  post "/", to: "home#login"
  get "logout", to: "home#logout", as: "logout"

  get "time_zone", to: "home#time_zone"

  get "consumers", to: "consumer#index", as: "consumers"
  scope "consumer/:uuid" do
    get "/", to: "consumer#show", as: "consumer"
    patch "/", to: "consumer#update"
    post "lock", to: "consumer#lock", as: "consumer_lock"
    delete "delete", to: "consumer#delete", as: "consumer_delete"
  end

  scope :frame do
    get "consumer/:uuid", to: "consumer#frame", as: "consumer_frame"
  end
end
