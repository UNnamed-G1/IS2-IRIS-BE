Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'

  get 'research_groups_news' => 'research_groups#news'
  get 'events_news' => 'events#news'
  
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
