HiThere::Engine.routes.draw do
  resources :courses, except: :destroy do
    member do 
      put :open
      put :close
    end
    resources :emails, except: :destroy
  end
end
