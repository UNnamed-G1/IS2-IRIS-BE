Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  post 'google_user_token' => 'google_user_token#create'
  # post 'google_auth' => 'google_user_tockens#create'

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
