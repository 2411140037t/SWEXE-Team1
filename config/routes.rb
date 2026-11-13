Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root "app#index"

  # App routes
  get "app/index"
end
