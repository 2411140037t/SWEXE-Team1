Rails.application.routes.draw do
  # App
  root "app#index"
  get "app/index" # /

  # User
  get "signup", to: "user#new" # /signup
  post "signup", to: "user#create"# /signup

  # Session
  get "login", to: "session#new" # /login
  post "login", to:  "session#create" # /login
  delete "logout", to: "session#destroy" # /logout

  # Report
  get "report", to: "report#index", as: :reports # /report
  get "report/new", to: "report#new", as: :new_report # /report/new
  post "report", to: "report#create", as: :post_report # /report
  get "report/:id", to: "report#show", as: :report # /report/:id
  get "report/:id/edit", to: "report#edit", as: :edit_report # /report/:id/edit
  patch "report/:id", to: "report#update" # /report/:id
  delete "report/:id", to: "report#destroy" # /report/:id

  # Ranking
  get "ranking/index" # /ranking

  # Other
  get "up" => "rails/health#show", as: :rails_health_check

  # @Staff
  namespace :staff do
    # Report
    get "report", to: "report#index", as: :reports # /staff/report
    get "report/:id", to: "report#show", as: :report # /staff/report/:id
    patch "report/:id", to: "report#update" # /staff/report/:id

    # Town
    get "town", to: "town#index", as: :towns # /staff/town
    get "town/:id", to: "town#show", as: :town # /staff/town/:id
  end
end
