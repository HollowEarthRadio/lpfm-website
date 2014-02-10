LpfmWebsite::Application.routes.draw do

  resources :events

  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :programs

  get "/about", controller: "home", action: 'about'
  get "/contact", controller: "home", action: 'contact'
  get "/schedule", controller: "home", action: 'schedule'
  get "/donate", controller: "home", action: 'donate'
  get "/volunteer", controller: "home", action: 'volunteer'
  get "/submissions", controller: "home", action: 'contribute'
  get "/faq", controller: "home", action: 'faq'
  get '/theseaportbeat', controller: "home", action: "theseaportbeat"
  get '/magma', controller: "home", action: "magma"
  get '/splash', controller: "home", action: "splash"
  root to: 'home', action: 'splash'
end
