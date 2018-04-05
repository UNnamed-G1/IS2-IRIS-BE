Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  post 'google_user_token' => 'google_user_token#create'

  get 'users/current' => 'users#current'
  get 'departments_by_faculty/:faculty_id', to: 'departments#by_faculty'
  get 'careers_by_department/:department_id', to: 'careers#by_department'

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
