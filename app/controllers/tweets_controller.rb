class TweetsController < ApplicationController

  get '/tweets' do
    authenticate
    @tweets = Tweet.all 
    erb :'tweets/tweets'
  end

  get '/tweets/new' do  
    authenticate
    erb :'tweets/new'
  end

  post '/tweets' do
    authenticate
    @tweet = Tweet.new(content: params[:content], user: current_user)
    if @tweet.save
      redirect '/tweets'
    else
      @error = "Cannot Create Tweet. Try Again."
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    authenticate
    @tweet = Tweet.find_by(id: params[:id])
    erb :'/tweets/show_tweet'
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by(id: params[:id])
    authorize(@tweet)
    erb :'/tweets/edit_tweet'
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by(id: params[:id])
    authorize(@tweet)
    if @tweet.update(content: params[:content])
      redirect '/tweets'
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by(id: params[:id])
    authorize(@tweet)
    @tweet.destroy
    redirect '/tweets'
  end
 
end
