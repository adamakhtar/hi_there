HiThere::Engine.routes.draw do
  resources :courses, except: :destroy do
    member do 
      put :open
      put :close
      put :terminate
    end
    resources :emails, controller: 'courses/emails' do
      member { put :reorder }
    end
    resources :form_setups, only: :index, controller: 'courses/form_setups'
    resources :subscriptions, only: :index, controller: 'courses/subscriptions'
  end

  resources :emails, only: nil do
    resource :preview, only: nil do
      member { get :deliver }
    end 
  end

  resources :subscriptions, only: [:new, :create]

  get 'confirmation_required' => 'subscriptions#confirmation_required'
  get 'confirmed' => 'subscriptions#confirmed', as: 'confirmed_subscription'
  get 'confirm/' => 'subscriptions#confirm', as: 'confirm_subscription'
  get 'invalid/' => 'subscriptions#invalid', as: 'invalid_subscription'
  get 'unsubscribe/' => 'subscriptions#destroy', as: 'unsubscribe_subscription'
  get 'unsubscribed/' => 'subscriptions#unsubscribed', as: 'unsubscribed_subscription'

  root to: 'courses#index'
end
