Rails.application.routes.draw do
  resources :entities
  resources :deleted_entities, only: [:index, :show]
  post "entities/:id/restore", to: 'deleted_entities#restore'
  root to: "entities#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
