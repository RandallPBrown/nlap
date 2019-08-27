Rails.application.routes.draw do
  resources :fergusons
  resources :districts
  resources :pcmi_contacts
  resources :pcmi_imports
  resources :mfg_parts
  resources :manufacturers
  resources :groups
  resources :teams
  resources :sections
  resources :procedures
  resources :contacts
  resources :dealers
  put 'agent_stats/all_stats' => 'agent_stats#all_stats'
  put 'agent_stats/csv_upload' => 'agent_stats#csv_upload'
  resources :agent_stats 
  resources :recipients
  resources :network_maps
  resources :messages
  resources :chatrooms
  get 'tools/snapshot'
  get 'network_map/index'
  get 'messages/message'
  get 'users/dashboard'
  get 'users/index'
  get 'tools/validator'
  get 'tools/ferguson'
  get 'tools/val'
  get 'tools/pendingreview'
  get 'parts/dashboard'
  get 'err_logs/dashboard'
  get 'entries/dashboard'
  get 'agent_department/index'
  get 'entry/dashboard'
  get 'entries/entry_breakdown'
  get 'entries/calendar'
  get 'entries/agent_list'
  get 'buying_groups/edit'
  get 'agents/new_entry'
  get 'agents/new_writeup'
  get 'agents/agent_breakdown' 
  get 'agents/breakdown_pdf', defaults: { format: 'pdf'} 
  get 'entries/new'
  get 'entries/form2'
  get 'tools/speed_test'
  get 'tools/procedure_view'
  get 'entries/agentview', to: 'entries#agentview'
  get 'daps/form2'  
  get 'home/dashboard'
  get 'myresults', to: 'entries#my_results', defaults: { format: 'csv'}  
  put 'parts/read_at' => 'parts#read_at'
  put 'tools/validator_email' => 'tools#validator_email'

  resources :tools do
      collection do
        get 'get_dealer'
        get 'get_district'
        put 'create_ferguson'
      end
    end
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
  resources :err_logs
  resources :err_names
  resources :err_statuses
  devise_for :users, :skip => [:registrations], controllers: {
        sessions: 'users/sessions'
        # registrations: 'users/registrations'
      }
  resources :users



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "users#dashboard"
end
