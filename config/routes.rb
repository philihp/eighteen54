Rails.application.routes.draw do
  get 'welcome/index'
  root 'welcome#index'

  resources :instances do
    resources :players
    resources :companies do
      resources :bids, only: [:destroy]
      member do
        post 'bid'
        post 'set_par_and_buy'
      end
    end
    member do
      post 'bump_phase'  # debug
      post 'bump_round'  # debug
      post 'next_player' # debug

      post 'auction_pass'
      post 'auction_buy'

      post 'stock_pass'
      post 'create_stub'
    end
  end
end
