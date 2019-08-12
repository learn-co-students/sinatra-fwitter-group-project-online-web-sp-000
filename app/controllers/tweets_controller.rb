require 'rack-flash'

class TweetsController < ApplicationController
  use Rack::Flash
  
  get '/tweets' do
    # binding.pry
    if is_logged_in?(session)
      @user = current_user(session)
      @tweets = Tweet.all
      erb :"/tweets/tweets"
    else
      flash[:message] = "You don't appear to be logged in.  Please login below."
      redirect "/login"
    end
  end

  post '/tweets' do
    # binding.pry
    @user = current_user(session)

    if !params[:content].empty?
      @user.tweets << Tweet.create(content: params[:content])
      @tweet = Tweet.last
      
      erb :"/tweets/edit_tweet"
    else
      flash[:message] = "Tweets can not be empty.  Please add content."
      redirect "/tweets/new"
    end
  end
  
  get '/tweets/new' do
    # binding.pry
    if is_logged_in?(session)
      @user = current_user(session)
      
      erb :"/tweets/new"
    else
      flash[:message] = "You don't appear to be logged in.  Please login below."
      redirect "/login"
    end
  end

  get '/tweets/:id' do
    if is_logged_in?(session)
      @tweet = Tweet.find(params[:id])

      erb :"tweets/show_tweet"
    else
      flash[:message] = "You don't appear to be logged in.  Please login below."
      redirect "/login"
    end
  end

  get '/tweets/:id/edit' do
    if is_logged_in?(session)
      @tweet = Tweet.find(params[:id])

      erb :"tweets/edit_tweet"
    else
      flash[:message] = "You don't appear to be logged in.  Please login below."
      redirect "/login"
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    # binding.pry
    if params[:content].empty?
      redirect "/tweets/#{@tweet.id}/edit"
    end

    if current_user(session).id == @tweet.user.id 
      @tweet.update(content: params[:content])

      redirect "/tweets"
    else
      flash[:message] = "You don't have permission to edit that tweet."
      redirect "/tweets"
    end
  end

  delete '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    # binding.pry
    if current_user(session).id == @tweet.user.id
      @tweet.destroy
      redirect "/tweets"
    else
      flash[:message] = "You don't have permission to delete that tweet."
      redirect "/tweets"
    end
  end

end
