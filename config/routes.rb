Rails.application.routes.draw do

  scope controller: :index do
    root action: :index
    get :signin, :signup, :forgot
  end

  resources :users, only: :create
  resources :sessions, only: %i(create destroy)
  namespace :auth do
    post :change_password
    get ":provider/callback" => :callback, as: :proviter_callback
    post ":provider/commit/:uid" => :commit, as: :commit
  end
  namespace :profile do
    root action: :show
    put '' => :update
    put :password, :avatar
  end

  get ':kind/new' => 'posts#new', constraints: { kind: /articles|blog_posts/ }, as: :new_post
  resources :posts, only: %i(create edit update destroy), controller: :posts do
    member do
      post :like
      delete 'like' => :dislike
    end
  end
  resources :articles, only: %i(index show) do
    collection { get "tags/:tag", action: :by_tag, as: :tag }
  end

  scope 'blogs', controller: 'blogs' do
    root action: :index, as: 'blogs'
    scope ':blog_id', as: 'blog' do
      post 'follow' => :follow
      delete 'follow' => :unfollow
      root 'blog_posts#index', as: ''
      resources :blog_posts, only: %i(index show), path: :posts, as: :posts
    end
  end

  # resources :blogs, only: :index do
  #   member do
  #     post 'follow'
  #     delete 'follow' => :unfollow
  #   end
  #   resources :blog_posts, only: %i(index show new create edit update destroy), path: :posts, as: :posts
  # end

  namespace :admin do
    root 'dashboard#index'
  end

end
