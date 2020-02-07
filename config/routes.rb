Rails.application.routes.draw do
  get "/projects/:project_id", to: "projects#show"
  post "/projects", to: "projects#create"

  get "/contestants", to: "contestants#index"
end
