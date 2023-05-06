Rails.application.routes.draw do
  root "home#index"

  post "/", to: "home#login"
  get "logout", to: "home#logout", as: "logout"

  get "commands", to: "commands#index", as: "commands"

  get "urls", to: "visit#index"

  get "time_zone", to: "home#time_zone"

  scope :frames do
    get "rickroll", to: "commands#rickroll_frame"
    post "rickroll", to: "commands#rickroll"

    get "redirect", to: "commands#redirect_frame"
    post "redirect", to: "commands#redirect"

    get "redirect_all", to: "commands#redirect_all_frame"
    post "redirect_all", to: "commands#redirect_all"

    get "change_urls", to: "commands#change_urls_frame"
    post "change_urls", to: "commands#change_urls"

    get "change_all_urls", to: "commands#change_all_urls_frame"
    post "change_all_urls", to: "commands#change_all_urls"

    get "change_images", to: "commands#change_images_frame"
    post "change_images", to: "commands#change_images"

    get "change_all_images", to: "commands#change_all_images_frame"
    post "change_all_images", to: "commands#change_all_images"

    get "prompt", to: "commands#prompt_frame"
    post "prompt", to: "commands#prompt"
  end
end
