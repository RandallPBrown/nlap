Rails.application.routes.draw do
  resources :wunatures
  resources :daps
  get 'users/dashboard'
  get 'users/index'
  get 'entries/dashboard'

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
  devise_for :users, :skip => [:registrations], controllers: {
        sessions: 'users/sessions'
        # registrations: 'users/registrations'
      }
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "users#dashboard"
end
