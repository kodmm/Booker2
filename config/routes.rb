Rails.application.routes.draw do
  
  devise_for :users
  root 'root#top'
  get 'about/show'
	resources :books
	resources :users, only:[:show, :edit, :update, :index]
  get "/home/about" => 'about#show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
