Rails.application.routes.draw do
    get 'home/index'
    
    resources :room, only: [:index, :show], param: :location

    root 'home#index'
end
