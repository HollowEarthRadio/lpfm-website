LpfmWebsite::Application.routes.draw do

  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :events
  resources :programs
  resources :users

  post 'admin/users/:id/update_role' => 'admin/users#update_role',  :id => /[0-9]+/, as: :admin_update_user_role

  get "/about", controller: "home", action: 'about'
  get "/contact", controller: "home", action: 'contact'
  get "/schedule", controller: "home", action: 'schedule'
  get "/donate", controller: "home", action: 'donate'
  get "/volunteer", controller: "home", action: 'volunteer'
  get "/submissions", controller: "home", action: 'contribute'
  get "/faq", controller: "home", action: 'faq'
  get "/shirts", controller: "home", action: 'shirts'
  get "/home", controller: "home", action: 'index'
  get '/theseaportbeat', controller: "home", action: "theseaportbeat"
  get '/magma', controller: "home", action: "magma"
  get '/splash', controller: "home", action: "splash"
  root to: 'home', action: 'splash'
end
