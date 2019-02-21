Rails.application.routes.draw do
  resources :parts
  resources :products
  resources :buying_groups
  resources :wunatures
  resources :daps
  resources :entries
  resources :create_join_table_agent_departments
  resources :occurrences
  resources :agent_department
  resources :writeups
  resources :occurences
  resources :roles
  resources :departments
  resources :agents
  devise_for :users, :skip => [:registrations], controllers: {
        sessions: 'users/sessions'
        # registrations: 'users/registrations'
      }
  resources :users
  
  get 'users/dashboard'
  get 'users/index'
  get 'tools/validator'
  get 'entries/dashboard'
  get 'agent_department/index'
  get 'entry/dashboard'
  get 'entries/calendar'
  get 'entries/agent_list'
  get 'agents/new_entry'
  get 'agents/new_writeup'  
  get 'entries/new'
  get 'entries/form2'
  get 'daps/form2'  
  get 'home/dashboard'
  get 'myresults', to: 'entries#my_results', defaults: { format: 'csv'}



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "users#dashboard"
end
