Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'

  get 'users/current' => 'users#current'
  get 'research_groups_news' => 'research_groups#news'
  get 'events_news' => 'events#news'

# Search
  # Nota el simbolo '#' se traduce a la ruta como '%23'
  get 'careers_by_rg#rg_id=:id' => 'careers#search_careers_by_rg'
  get 'careers_by_user#usr_id=:id' => 'careers#search_careers_by_user'
  get 'careers_by_dept#dept_id=:id' => 'careers#search_careers_by_dept'
  get 'events_by_rg#rg_id=:id' => 'events#search_events_by_rg'
  get 'events_by_user#usr_id=:id' => 'events#search_events_by_user'
  get 'events_by_state#status=:status' => 'events#search_events_by_state'
  get 'events_by_freq#freq=:freq' => 'events#search_events_by_freq'
  get 'events_by_type#type=:type' => 'events#search_events_by_type'
  get 'publications_by_rg#rg_id=:id' => 'publications#search_publications_by_rg'
  get 'publications_by_user#usr_id=:id' => 'publications#search_publications_by_user'
  get 'publications_by_type#type=:type' => 'publications#search_publications_by_type'
  get 'p_by_rg_and_type#rg_id=:id#type=:type' => 'publications#p_by_rg_and_type'
  get 'rgs_by_career#career_id=:id' => 'research_groups#search_rgs_by_career'
  get 'rgs_by_name#keywords=:keywords' => 'research_groups#search_rgs_by_name'
  get 'rgs_by_class#cl_type=:cl_type' => 'research_groups#search_rgs_by_class'
  get 'rgs_by_department#dep_id=:id' => 'research_groups#search_rgs_by_department'
  get 'rs_by_rg#rg_id=:id' => 'research_subjects#search_rs_by_rg'
  get 'rs_by_name#keywords=:keywords' => 'research_subjects#search_rs_by_name'
  get 'rs_by_user#usr_id=:id' => 'research_subjects#search_rs_by_user'
  get 'find_schedules_by_user#usr_id=:id' => 'schedules#find_schedules_by_user'

#Stadistics
  # Nota el simbolo '#' se traduce a la ruta como '%23'
  get 'num_publications_by_rg#rg_id=:id' => 'publications#num_publications_by_rg'
  get 'num_publications_by_user#usr_id=:id' => 'publications#num_publications_by_user'
  get 'num_publications_by_type#type=:type' => 'publications#num_publications_by_type'
  get 'num_publications_by_rg_and_type#rg_id=:id#type=:type' => 'publications#num_publications_by_rg_and_type'
  get 'num_rs_by_rg#rg_id=:id' => 'research_subjects#num_rs_by_rg'
  get 'num_rs_by_user#usr_id=:id' => 'research_subjects#num_rs_by_user'

  resources :publications
  resources :research_groups
  resources :events
  resources :relationships
  resources :photos
  resources :careers
  resources :departments
  resources :faculties
  resources :research_subjects
  resources :schedules
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
