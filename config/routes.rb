
Rails.application.routes.draw do
  post "user_token" => "user_token#create"
  post "google_user_token" => "google_user_token#create"

  get "users/current" => "users#current"
  post "comments" => "incoming_mails#receive_comments"

  get "research_groups_news" => "research_groups#news"
  get "events_news" => "events#news"

  get "research_groups/photo/:id" => "research_groups#get_photo"
  get "/user_by_username" => "users#by_username"
  post "follow" => "users#follow_user" # param must be :id_followed
  post "unfollow" => "users#unfollow_user" # param must be :id_followed
  get "following" => "users#following"
  get "curr_following" => "users#curr_following"
  get "followers" => "users#followers"

  post "research_groups/join/" => "research_groups#join_research_group"

  post "events/invite_users" => "events#invite_users" # params: users_ids & id
  post "events/remove_invitation" => "events#remove_invitation" # params: user_id & id
  get "events/invited_users" => "events#get_invited_users" # params: ?id="something"
  get "events/attendees" => "events#get_attendees" # params: ?id="something"
  get "events/authors" => "events#get_authors" # params: ?id="something"

  post "schedules/set_as_busy" => "schedules#set_schedule_as_busy"
  post "schedules/set_as_idle" => "schedules#set_schedule_as_idle"

  # Search
  # Nota el simbolo '#' se traduce a la ruta como '%23'
  get "careers_by_rg" => "careers#search_careers_by_rg"
  get "careers_by_user" => "careers#search_careers_by_user"
  get "careers_by_dept" => "careers#search_careers_by_dept"
  get "depts_by_faculty" => "departments#search_deps_by_faculty"
  get "events_by_rg" => "events#search_events_by_rg"
  get "events_by_user" => "events#search_events_by_user"
  get "events_by_state" => "events#search_events_by_state"
  get "events_by_freq" => "events#search_events_by_freq"
  get "events_by_type" => "events#search_events_by_type"
  get "events_by_editable" => "events#evs_by_editable"
  get "publications_by_name" => "publications#search_publications_by_name"
  get "publications_by_rg" => "publications#search_publications_by_rg"
  get "publications_by_user" => "publications#search_publications_by_user"
  get "publications_by_type" => "publications#search_publications_by_type"
  get "p_by_rg_and_type" => "publications#search_p_by_rg_and_type"
  get "rgs_by_career" => "research_groups#search_rgs_by_career"
  get "rgs_by_name" => "research_groups#search_rgs_by_name"
  get "rgs_by_user" => "research_groups#search_rgs_by_user"
  get "rgs_by_current_user" => "research_groups#search_rgs_by_current_user"
  get "rgs_by_class" => "research_groups#search_rgs_by_class"
  get "rgs_by_department" => "research_groups#search_rgs_by_department"
  get "rs_by_rg" => "research_subjects#search_rs_by_rg"
  get "rs_by_name" => "research_subjects#search_rs_by_name"
  get "rs_by_user" => "research_subjects#search_rs_by_user"
  get "find_schedules_by_user" => "schedules#find_schedules_by_user"

  #Reports

  get "reports/user_history", to: "reports#total_user_history"
  get "reports/rgs_history", to: "reports#total_rgs_history"
  get "reports/rep_by_user", to: "reports#history_by_user"
  get "reports/rep_by_rg", to: "reports#history_by_rg"

  #Statistics

  get "statistics/num_publications_by_user", to: "statistics#num_publications_by_user"
  get "statistics/num_publications_by_rg", to: "statistics#num_publications_by_rg"
  get "statistics/recent_publications_by_user", to: "statistics#recent_publications_by_user"
  get "statistics/recent_publications_by_rg", to: "statistics#recent_publications_by_rg"
  get "statistics/num_publications_by_user_and_type", to: "statistics#num_publications_by_user_and_type"
  get "statistics/num_publications_by_rg_and_type", to: "statistics#num_publications_by_rg_and_type"
  get "statistics/overall_num_pubs_by_users_in_rg", to: "statistics#overall_num_pubs_by_users_in_rg"
  get "statistics/average_publications_in_a_period_by_rg", to: "statistics#average_publications_in_a_period_by_rg"
  get "statistics/average_publications_in_a_period_by_user", to: "statistics#average_publications_in_a_period_by_user"
  get "statistics/num_publications_of_users", to: "statistics#num_publications_of_users"
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
