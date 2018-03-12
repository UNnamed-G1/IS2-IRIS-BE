Rails.application.routes.draw do
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
