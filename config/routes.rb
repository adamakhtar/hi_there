HiThere::Engine.routes.draw do
  resources :courses do
    resources :emails, only: [:create, :show, :new, :edit]
  end
end
