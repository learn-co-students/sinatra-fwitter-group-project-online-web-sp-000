class UserController < ApplicationController


  # Index Action
  get '/users' do
    @users = User.all
    erb :'/users/index'
  end
  
  # New Action
  get '/users/new' do
    @tweets = Tweet.all
    erb :'/users/new'
  end
  
  # Create Action
  post '/users' do
    user = User.create(params['user'])
    redirect "/tweets"
  end
  
  # Show Action
  get '/users/:id' do
    @user = User.find(params[:id])
    erb :'/users/show'
  end
  
  # Edit Action
  get '/users/:id/edit' do
    @user = User.find(params[:id])
    @tweets = Tweet.all
    erb :'/users/edit'
  end
  
  # Patch Action
  patch '/users/:id' do
    params[:song_info]['tweet_ids'].clear if !params[:user].keys.include?('tweet_ids')
    user = User.find(params[:id])
    user.update(params['user'])

    user.tweets << Tweet.create(name: params['tweet_name']) unless params['tweet_name'].empty?
    user.save
    redirect "users/#{user.id}"
  end
  
  # Delete Action
  delete '/users/:id' do
    user = User.find(params[:id])
    user.delete
  end
  
end