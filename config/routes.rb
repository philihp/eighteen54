Rails.application.routes.draw do
  resources :instances do
    member do
      post 'bump_phase'
      post 'bump_round'
    end
  end
end
