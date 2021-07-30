Rails.application.routes.draw do

  get '/', to: 'welcome#index'

  ## Why do we have these routes listed twice..?  Commenting this line out doesn't appear to change anything
  # resources :merchants, module: :merchant, only: [:show, :index]

  resources :merchants, module: :merchant, only: [:show, :index] do
      resources :items
      resources :invoices
      resources :dashboard, only: [:index]
  end

  namespace :admin do
    resources :merchants
    resources :invoices
  end
end
