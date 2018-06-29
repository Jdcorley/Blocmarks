Rails.application.routes.draw do
  get 'incoming/create'
  devise_for :users, controllers: {sessions: 'users/sessions'}
  devise_scope :user do 
    get 'sign_in', to: 'devise/sessions#new'
  end

  resources :topics, shallow: true  do 
    resources :bookmarks
  end 

  post :incoming, to: 'incoming#create'

  get 'about' => 'welcome#about'
  root 'welcome#index'
end
