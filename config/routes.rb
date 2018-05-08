
Rails.application.routes.draw do
  
  # LOGIN
  post "login", to: "user_token#create"
  post "google_login", to: "google_user_token#create"
  
  # MAILERS 
  post "comments", to: "incoming_mails#receive_comments"
  
  # post "schedules/set_as_busy" => "schedules#set_schedule_as_busy"
  # post "schedules/set_as_idle" => "schedules#set_schedule_as_idle"

  # # Search
  # # Nota el simbolo '#' se traduce a la ruta como '%23'
  # get "careers_by_rg" => "careers#search_careers_by_rg"
  # get "careers_by_user" => "careers#search_careers_by_user"
  # get "careers_by_dept" => "careers#search_careers_by_dept"
  # get "depts_by_faculty" => "departments#search_deps_by_faculty"
  # get "events_by_rg" => "events#search_events_by_rg"
  # get "events_by_user" => "events#search_events_by_user"
  # get "events_by_state" => "events#search_events_by_state"
  # get "events_by_freq" => "events#search_events_by_freq"
  # get "events_by_type" => "events#search_events_by_type"  
  # get "publications_by_name" => "publications#search_publications_by_name"
  # get "publications_by_rg" => "publications#search_publications_by_rg"
  # get "publications_by_user" => "publications#search_publications_by_user"
  # get "publications_by_type" => "publications#search_publications_by_type"
  # get "p_by_rg_and_type" => "publications#search_p_by_rg_and_type"
  # get "rgs_by_career" => "research_groups#search_rgs_by_career"
  # get "rgs_by_name" => "research_groups#search_rgs_by_name"
  # get "rgs_by_user" => "research_groups#search_rgs_by_user"
  # get "rgs_by_current_user" => "research_groups#search_rgs_by_current_user"
  # get "rgs_by_class" => "research_groups#search_rgs_by_class"
  # get "rgs_by_department" => "research_groups#search_rgs_by_department"
  # get "rs_by_rg" => "research_subjects#search_rs_by_rg"
  # get "rs_by_name" => "research_subjects#search_rs_by_name"
  # get "rs_by_user" => "research_subjects#search_rs_by_user"
  # get "find_schedules_by_user" => "schedules#find_schedules_by_user"

  # #Reports

  # get "reports/user_history", to: "reports#total_user_history"
  # get "reports/rgs_history", to: "reports#total_rgs_history"
  # get "reports/rep_by_user", to: "reports#history_by_user"
  # get "reports/rep_by_rg", to: "reports#history_by_rg"

  # #Statistics

  # get "statistics/num_publications_by_user", to: "statistics#num_publications_by_user"
  # get "statistics/num_publications_by_rg", to: "statistics#num_publications_by_rg"
  # get "statistics/recent_publications_by_user", to: "statistics#recent_publications_by_user"
  # get "statistics/recent_publications_by_rg", to: "statistics#recent_publications_by_rg"
  # get "statistics/num_publications_by_user_and_type", to: "statistics#num_publications_by_user_and_type"
  # get "statistics/num_publications_by_rg_and_type", to: "statistics#num_publications_by_rg_and_type"
  # get "statistics/overall_num_pubs_by_users_in_rg", to: "statistics#overall_num_pubs_by_users_in_rg"
  # get "statistics/average_publications_in_a_period_by_rg", to: "statistics#average_publications_in_a_period_by_rg"
  # get "statistics/average_publications_in_a_period_by_user", to: "statistics#average_publications_in_a_period_by_user"
  # get "statistics/num_publications_by_user_in_a_period", to: "statistics#num_publications_by_user_in_a_period"
  # get "statistics/num_publications_by_rg_in_a_period", to: "statistics#num_publications_by_rg_in_a_period"

  
  resources :users do
    collection do      
      scope :current do # Puts /current path before the route
        get "following", to: "users#current_user_following"        

        post "follow", to: "users#follow_user" # param must be :id_followed
        post "unfollow", to: "users#unfollow_user" # param must be :id_followed
        get "editable_events"
      end

      get "current"      
      get "get_user/:username", to: "users#get_user_by_username"
    end

    member do # Generated route: /users/:id/route 
      get "following"
      get "followers"
    end
  end

  resources :research_groups do
    collection do 
      get "news"
    end
    
    member do 
      get "photo", to: "research_groups#get_photo"
      
      post "join", to: "research_groups#join_to_research_group"
    end
  end
    
  resources :events do 
    collection do
      get "news"
    end
    member do
      get "invited_users" => "events#get_invited_users"
      get "attendees" => "events#get_attendees"
      get "authors" => "events#get_authors"
      
      post "invite_users" # params: users_ids
      post "remove_invitation" # params: user_id
    end
  end

  # resources :publications
  # resources :relationships
  # resources :photos
  # resources :careers
  # resources :departments
  # resources :faculties
  # resources :research_subjects
  # resources :schedules
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
