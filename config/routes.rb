Rails.application.routes.draw do
  get 'welcome/index'
  root 'welcome#index'

  resources :instances do
    resources :players
    resources :company do
      member do
        post 'bid'
      end
    end
    member do
      post 'bump_phase'  # debug
      post 'bump_round'  # debug
      post 'next_player' # debug

      post 'auction_pass'
      post 'auction_buy'
    end
  end
end
