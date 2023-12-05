Rails.application.routes.draw do
  root 'qr_codes#index'
  resources :qr_codes
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
