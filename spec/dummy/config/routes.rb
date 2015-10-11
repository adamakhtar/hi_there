Rails.application.routes.draw do

  devise_for :users
  get 'home/index'
  get 'home/landing_page', as: :landing_page

  root to: "home#index"

  mount HiThere::Engine => "/hi_there"
end
