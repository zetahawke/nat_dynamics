Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  get '/contact', to: 'home#contact', as: :contact
  
  namespace :admin do
    get 'modules_menu', to: 'home#modules_menu'
    get 'providers_menu', to: 'home#providers_menu'

    get '/', to: 'home#index', as: :root
    resources :invoices do
      collection do
        get 'white_list'
        post 'download_list'
      end
    end
  end
end
