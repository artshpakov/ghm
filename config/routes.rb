Rails.application.routes.draw do

  scope controller: :index do
    root action: :index
    get :signin, :signup, :forgot
  end

  resources :users, only: :create
  resources :sessions, only: %i(create destroy)
  namespace :auth do
    post :change_password
    get "/:provider/callback" => :callback, as: :proviter_callback
    post "/:provider/commit/:uid" => :commit, as: :commit
  end
  namespace :profile do
    root action: 'show'
    put '' => :update
    put :password, :avatar
  end


  namespace :admin do
    root 'dashboard#index'
  end

end
