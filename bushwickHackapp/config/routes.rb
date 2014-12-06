Rails.application.routes.draw do

root to: 'maps#index'
resources :maps, only: [:index, :show] 
resources :location, only: [:new]
end
