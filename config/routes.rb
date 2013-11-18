LpfmWebsite::Application.routes.draw do
  root 'home#index'

  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
