Rails.application.routes.draw do
  root 'admin/qr_codes#index'
  scope '/a/', module: 'admin' do
    resources :qr_codes
  end
  get ':path_alias', to: 'qr_codes#show', as: "qr_code_link"

  namespace :api do
    namespace :v1 do
      resources :qr_codes
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
