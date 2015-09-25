HiThere::Engine.routes.draw do
  resources :courses, except: :destroy do
    resources :emails, except: :destroy
  end
end
