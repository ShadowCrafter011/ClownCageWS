Rails.application.routes.draw do
  root "salbot#index"
  get "agb", to: "salbot#agb", as: "salbot_agb"
  get "down", to: "home#download"
  get "download", to: "home#download"

  scope :admin do
    get "/", to: "home#index", as: "admin"
    post "/", to: "home#login"
    get "logout", to: "home#logout", as: "logout"
    get "idlist", to: "home#idlist", as: "idlist"
    get "reset", to: "home#test_reset"

    get "action_status/:callback_uuid", to: "actions#action_status"

    get "consumers", to: "consumer#index", as: "consumers"
    scope "consumer/:uuid" do
      get "/", to: "consumer#show", as: "consumer"
      patch "/", to: "consumer#update"
      post "lock", to: "consumer#lock", as: "consumer_lock"
      delete "delete", to: "consumer#delete", as: "consumer_delete"

      get "navbar", to: "consumer#navbar", as: "navbar"

      scope "folder/:folder_id" do
        get "/", to: "consumer#folder", as: "folder"
      end

      scope "action/:action_id" do
        get "/", to: "actions#frame", as: "action_frame"
        post "dispatch", to: "actions#dispatch_action", as: "action_dispatch"
        post "force_dispatch", to: "actions#force_dispatch", as: "action_force_dispatch"
        post "toggle", to: "actions#toggle", as: "toggle_action"
        get "edit", to: "actions#edit", as: "action_edit"
        post "edit", to: "actions#update"
        post "reset", to: "actions#reset", as: "action_reset"
      end
    end

    scope :frame do
      get "consumer/:uuid", to: "consumer#frame", as: "consumer_frame"
    end
  end
end
