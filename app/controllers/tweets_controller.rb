class TweetsController < ApplicationController

  get '/tweets' do
    if !logged_in?
    redirect '/login'
    end
    @tweets = Tweet.all
    erb :'/tweets/tweets'
  end

  get '/tweets/new' do 
    erb :new 
  end 


post '/tweets' do
  redirect '/login' if !logged_in?
    redirect '/tweets/new'
    if params[:tweet][:content].empty?
    @tweet = Tweet.create(params[:tweet])
    @tweet.user_id = User.find_by(username: current_user).id
    @tweet.save
    redirect "/tweets/#{@tweet.id}"
    end
  end
  post '/tweets' do
    redirect '/login' if !logged_in?

    @tweet = current_user.tweets.create(params[:tweet])
    if @tweet.save
      redirect "/tweets/#{@tweet.id}"
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    redirect '/login' if !logged_in?
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/show'
  end

  get '/tweets/:id/edit' do
    redirect '/login' if !logged_in?
    @tweet = Tweet.find(params[:id])
    redirect '/tweets' if @tweet.user != current_user
    erb :'/tweets/edit'
  end

  delete '/tweets/:id/delete' do
    tweet = current_user.tweets.find_by(id: params[:id])
    if tweet && tweet.destroy
      redirect '/tweets'
    else
      redirect "/tweets/#{ params[:id] }"
    end
  end



  post '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    redirect "/" if @tweet.user != current_user
    redirect "/tweets/#{@tweet.id}/edit" if params[:tweet][:content].empty?
    @tweet.content = params[:tweet][:content]
    @tweet.save
    redirect "/tweets/#{@tweet.id}"
  end
end