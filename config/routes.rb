Rails.application.routes.draw do
  root 'qr_codes#index'
  scope '/a/' do
    resources :qr_codes, except: [:show]
  end
  get ':external_id', to: 'qr_codes#show', as: "qr_code_link"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
