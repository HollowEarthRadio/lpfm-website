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
  #get "/donate", controller: "home", action: 'donate'
  get "/donate", to: redirect("https://www.indiegogo.com/projects/hollow-earth-radio-finally-on-the-airwaves--2#/")
  get "/volunteer", controller: "home", action: 'volunteer'
  get "/submissions", controller: "home", action: 'contribute'
  get "/faq", controller: "home", action: 'faq'
  get "/home", controller: "home", action: 'index'
  get '/theseaportbeat', controller: "home", action: "theseaportbeat"
  get "/magma" => redirect("http://www.magmafest.org")
  get '/splash', controller: "home", action: "splash"
  get '/campaign', controller: "home", action: "campaign"
  get '/shirts', to: redirect('http://hollowearthradio.bandcamp.com/merch/')
  get '/listen', controller: "home", action: "listen"

  #root to: 'home', action: 'index'
  root to: 'home', action: 'campaign'
end
