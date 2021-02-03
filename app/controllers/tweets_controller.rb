class TweetsController < ApplicationController

  get '/tweets' do
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      @tweets = Tweet.all
      erb :'tweets/index'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if Helpers.is_logged_in?(session)
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if params[:content].blank?
      redirect 'tweets/new'
    else
      user = Helpers.current_user(session)
      user.tweets << Tweet.new(content: params[:content])
      redirect "/users/#{user.slug}"
    end
  end

  get '/tweets/:id' do
    if Tweet.exists?(params[:id])
      @tweet = Tweet.find(params[:id])
    end

    if session[:user_id] && @tweet
      erb :'tweets/show'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if !Helpers.is_logged_in?(session)
      redirect '/login'
    else
      @tweet = Tweet.find(params[:id])
      if Helpers.current_user(session).tweets.include?(@tweet)
        erb :'/tweets/edit'
      else
        redirect '/tweets'
      end
    end
  end

  patch '/tweets/:id' do
    tweet = Tweet.find(params[:id])
    if params[:content].blank?
      redirect "/tweets/#{tweet.id}/edit"
    else
      tweet.update(content: params[:content])
      redirect "/tweets/#{tweet.id}"
    end
  end

  delete '/tweets/:id' do
    tweet = Tweet.find(params[:id])
    if session[:user_id]
      if Helpers.current_user(session).tweets.include?(tweet)
        Tweet.destroy(tweet.id)
        redirect '/tweets'
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end

end
