Rails.application.routes.draw do
  # App
  root "app#index"
  get "app/index" # /

  # User
  get "signup", to: "user/new" # /signup
  post "signup", to: "user/create"# /signup

  # Session
  get "login", to: "session/new" # /login
  post "login", to:  "session/create" # /login
  delete "logout", to: "session/destroy" # /logout

  # Report
  get "report/index" # /report
  get "report/new" # /report/new
  post "report", to: "report/create" # /report
  get "report/show" # /report/:id
  get "report/edit" # /report/:id/edit
  patch "report", to: "report/update" # /report/:id
  delete "report", to: "report/destroy" # /report/:id

  # Ranking
  get "ranking/index" # /ranking

  # Other
  get "up" => "rails/health#show", as: :rails_health_check

  # @Staff
  namespace :staff do
    # Report
    get "report/index" # /staff/report
    get "report/show" # /staff/report/:id
    patch "report", to: "report/update" # /staff/report/:id

    # Town
    get "town/index" # /staff/town
    get "town/show" # /staff/town/:id
  end
end
