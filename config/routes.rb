Psychoviz::Application.routes.draw do

  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'

  root to: "quiz#index"

  resources :quiz, :sessions, :scores

  get '/friends', to: 'quiz#get_friends'

end
