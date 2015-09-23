Rails.application.routes.draw do

  get 'home/index'

  root to: "home#index"

  mount HiThere::Engine => "/hi_there"
end
