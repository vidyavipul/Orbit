Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "home#index"

  # Authentication routes
  get "signup", to: "users#new"
  post "signup", to: "users#create"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  get "logout", to: "sessions#logout_via_get"

  # Dashboard route
  get "dashboard", to: "dashboards#index", as: :dashboard

  # User CRUD routes
  get "users", to: "users#index", as: :users
  post "users", to: "users#create"
  get "users/new", to: "users#new", as: :new_user
  get "users/:id/edit", to: "users#edit", as: :edit_user
  get "users/:id", to: "users#show", as: :user
  put "users/:id", to: "users#update"
  patch "users/:id", to: "users#update"
  delete "users/:id", to: "users#destroy"

  # Project CRUD routes
  get "projects", to: "projects#index", as: :projects
  post "projects", to: "projects#create"
  get "projects/new", to: "projects#new", as: :new_project
  get "projects/:id/edit", to: "projects#edit", as: :edit_project
  get "projects/:id", to: "projects#show", as: :project
  put "projects/:id", to: "projects#update"
  patch "projects/:id", to: "projects#update"
  delete "projects/:id", to: "projects#destroy"

  # Task CRUD routes (Shallow manually nested)
  get "projects/:project_id/tasks", to: "tasks#index", as: :project_tasks
  post "projects/:project_id/tasks", to: "tasks#create"
  get "projects/:project_id/tasks/new", to: "tasks#new", as: :new_project_task

  get "tasks", to: "tasks#index", as: :tasks
  get "tasks/:id/edit", to: "tasks#edit", as: :edit_task
  get "tasks/:id", to: "tasks#show", as: :task
  put "tasks/:id", to: "tasks#update"
  patch "tasks/:id", to: "tasks#update"
  delete "tasks/:id", to: "tasks#destroy"

  # Comment CRUD routes (Shallow manually nested)
  post "tasks/:task_id/comments", to: "comments#create", as: :task_comments
  get "comments/:id/edit", to: "comments#edit", as: :edit_comment
  put "comments/:id", to: "comments#update"
  patch "comments/:id", to: "comments#update"
  delete "comments/:id", to: "comments#destroy", as: :comment
end
