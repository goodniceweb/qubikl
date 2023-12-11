Rails.application.routes.draw do
  root 'admin/qr_codes#index'
  devise_for :users
  scope '/a/', module: 'admin' do
    resources :qr_codes
    resources :domains, as: :user_domains, except: :show
    resources :users, only: :update
  end
  get ':path_alias', to: 'qr_codes#show', as: "qr_code_link"

  namespace :api do
    namespace :v1 do
      resources :qr_codes, only: [:index, :create, :show]
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
