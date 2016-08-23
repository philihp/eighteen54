Rails.application.routes.draw do
  resources :players
  resources :instances do
    member do
      post 'bump_phase'
      post 'bump_round'
    end
  end
end
