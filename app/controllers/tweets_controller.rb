class TweetsController < ApplicationController
  
  
  get '/signup' do 
    @tweets = Tweet.all
   erb :"tweets/tweets"
   end 
  
   get '/tweets' do
    redirect '/login' if !logged_in?
    erb :'/tweets/create_tweet'
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

# Shows an individual tweet
  get '/tweets/:id' do
    redirect '/login' if !logged_in?
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/show'
  end

  #Deletes a tweet.
  delete '/tweets/:id/delete' do
    tweet = current_user.tweets.find_by(id: params[:id])
    if tweet && tweet.destroy
      redirect '/tweets'
    else
      redirect "/tweets/#{ params[:id] }"
    end
  end

  get '/tweets/:id/edit' do
    redirect '/login' if !logged_in?
    @tweet = Tweet.find(params[:id])
    redirect '/tweets' if @tweet.user != current_user #I don't see a lot of students checking the tweet's user id. Good job! -@mendelB
    erb :'/tweets/edit'
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