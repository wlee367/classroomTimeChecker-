Rails.application.routes.draw do
    
    get '/abbreviations', to: 'home#abbrev'
    get 'home/index'
    
    resources :room, only: [:index, :show], param: :location
    resources :buildings, only: [:index, :show], param: :building

    root 'home#index'
end
