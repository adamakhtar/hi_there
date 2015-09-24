HiThere::Engine.routes.draw do
  resources :courses do
    resources :emails, only: [:show, :new, :edit]
  end
end
