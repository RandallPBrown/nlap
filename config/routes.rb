Rails.application.routes.draw do
  get 'entries/dashboard'

  get 'entry/dashboard'

  get 'home/dashboard'

  resources :entries
  resources :create_join_table_agent_departments
  resources :occurrences
  resources :agent_department
  get 'agent_department/index'

  resources :writeups
  resources :occurences
  resources :roles
  resources :departments
  resources :agents
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "dashboard#index"
end
