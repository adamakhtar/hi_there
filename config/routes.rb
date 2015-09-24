HiThere::Engine.routes.draw do
  resources :courses, only:  [:index, :show, :edit, :new] do
    resources :emails, only: [:show, :new, :edit]
  end
end
