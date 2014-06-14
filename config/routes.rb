Rails.application.routes.draw do
  resources :photos do
    collection do
      get 'search'
    end
  end
end
