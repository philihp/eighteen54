Rails.application.routes.draw do
  get 'welcome/index'
  root 'welcome#index'

  resources :instances do
    resources :players
    member do
      post 'bump_phase'
      post 'bump_round'
    end
  end
end
