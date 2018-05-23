Rails.application.routes.draw do
  
  devise_for :users, controllers: {sessions: 'users/sessions'}
  devise_scope :user do 
    get 'sign_in', to: 'devise/sessions#new'
  end

  resources :topics do 
    resources :bookmarks, only: [:new, :show, :destory]
  end 

  get 'about' => 'welcome#about'
  root 'welcome#index'
end
