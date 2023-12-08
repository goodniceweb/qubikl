Rails.application.routes.draw do
  root 'qr_codes#index'
  scope '/a/' do
    resources :qr_codes, except: [:show]
  end
  get ':path_alias', to: 'qr_codes#show', as: "qr_code_link"

  namespace :api do
    namespace :v1 do
      resources :qr_codes
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
