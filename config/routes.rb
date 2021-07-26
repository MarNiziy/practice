Rails.application.routes.draw do
	devise_for :users

	root to: 'feed_posts#index'

	resources :users, only: [:index, :show, :edit, :update] do
		resources :posts do
			resources :comments
			resources :likes
		end
		resources :followers, only: :index
		resources :followings, only: :index
	end

	resources :follows, only: [:create, :destroy]
end
