Rails.application.routes.draw do

  devise_for :users
  get 'home/index'

  root to: "home#index"

  mount HiThere::Engine => "/hi_there"
end
