
Rails.application.routes.draw do
  
  # LOGIN
  post "login", to: "user_token#create"
  post "google_login", to: "google_user_token#create"
  
  # MAILERS
  scope :mailing do
    post "comments", to: "incoming_mails#receive_comments"  
  end
  
  # SEARCH
  scope :search do
    get "events", to: "search#events_by_name"
    get "publications", to: "search#publications_by_name"
    get "research_groups", to: "search#research_groups_by_name"
    get "users", to: "search#users_by_name_or_username"
  end


  resources :users do
    collection do      
      scope :current do # Puts /current path before the route
        get "following", to: "users#current_user_following"        

        post "follow", to: "users#follow_user" # param must be :id_followed
        post "unfollow", to: "users#unfollow_user" # param must be :id_followed
        get "editable_events"
        get "schedule", to: "users#schedules"
        get "research_groups", to: "users#research_groups_current"
        
        post "request_join_research_group", to: "users#request_join_research_group"
        
        delete "cancel_request", to: "users#cancel_request_join_research_group"
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
      get "requested"
      get "accepted"
      post "request_create"
    end
    
    member do 
      get "available_users", to: "research_groups#available_users_to_add"

      post "add_users", to: "research_groups#add_users"
      
      put "accept_new_group"
      put "reject_new_group"

      put "user_as_retired", to: "research_groups#change_user_as_retired"
      put "user_as_active", to: "research_groups#change_user_as_active"
      put "user_as_lider", to: "research_groups#change_user_as_lider"
      put "user_as_member", to: "research_groups#change_user_as_member"
      
      put "accept_request", to: "research_groups#change_user_as_member"      
      delete "reject_request", to: "research_groups#remove_user"
    end
  end
    
  resources :events do 
    collection do
      get "news"
    end
    member do
      get "invited_users", to: "events#get_invited_users"
      get "attendees", to: "events#get_attendees"
      get "authors", to: "events#get_authors"
      get "available_users", to: "events#available_users"
      
      post "invite_users" # params: users_ids
      post "remove_invitation" # params: user_id
    end
  end

  resources :schedules do 
    member do
      put "set_as_idle", to: "schedules#set_schedule_as_idle"
      put "set_as_busy", to: "schedules#set_schedule_as_busy"
    end
  end

  scope :reports do 
    get "user_history", to: "reports#total_user_history"
    get "research_groups_history", to: "reports#total_rgs_history"
    get "users/:id/publications_history", to: "reports#history_by_user"
    get "research_group/:id/publications_history", to: "reports#history_by_rg"    
  end
  
  scope :statistics do
    scope :users do
      scope ':id' do
        get "num_publications", to: "statistics#num_publications_by_user"
        get "recent_publications", to: "statistics#recent_publications_by_user"
        get "num_publications_by_type", to: "statistics#num_publications_by_user_and_type"
        get "average_publications_in_a_period", to: "statistics#average_publications_in_a_period_by_user"
        get "num_publications_in_a_period", to: "statistics#num_publications_by_user_in_a_period"
      end
    end

    scope :research_groups do 
      scope ':id' do
        get "num_publications", to: "statistics#num_publications_by_rg"
        get "recent_publications", to: "statistics#recent_publications_by_rg"
        get "num_publications_by_type", to: "statistics#num_publications_by_rg_and_type"
        get "average_publications_in_a_period", to: "statistics#average_publications_in_a_period_by_rg"
        get "num_publications_in_a_period", to: "statistics#num_publications_by_rg_in_a_period"
        get "overall_num_publications_by_members", to: "statistics#overall_num_pubs_by_users_in_rg"
      end
    end

  end

  resources :departments do 
    member do
      get "careers", to: "departments#search_carrers"
    end
  end

  resources :faculties do
    member do
      get "departments", to: "faculties#search_departments"
    end
  end

  resources :careers do
    member do
      get "research_groups", to: "careers#get_research_groups"
    end
  end

  resources :publications
  resources :relationships
  resources :photos
  resources :research_subjects

  # # ROUTES NOT USED YET
  # get "events_by_state" => "events#search_events_by_state"
  # get "events_by_freq" => "events#search_events_by_freq"
  # get "events_by_type" => "events#search_events_by_type"  
  # get "publications_by_type" => "publications#search_publications_by_type"
  
  # get "rgs_by_class" => "research_groups#search_rgs_by_class"
  # get "rgs_by_department" => "research_groups#search_rgs_by_department"
  # get "rs_by_name" => "research_subjects#search_rs_by_name"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
