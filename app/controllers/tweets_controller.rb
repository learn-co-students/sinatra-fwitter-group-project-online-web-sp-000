class TweetsController < ApplicationController


  get '/tweets' do
    if session[:user_id]
      @user = Helpers.current_user(session)
      @tweets = Tweet.all
      erb :"tweets/index"
    else
      
      redirect "/login"
    end
  end

  get '/tweets/new' do
    if Helpers.is_logged_in?(session)
      erb :"tweets/new"
    else
      redirect "/login"
    end
  end

  get '/tweets/:id' do
    if Helpers.is_logged_in?(session)
      @tweet = Tweet.find_by(id: params[:id])
      erb :"tweets/show"
    else
      redirect "/login"
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by(id: params[:id])
    if Helpers.is_logged_in?(session) && Helpers.current_user(session) == @tweet.user
      erb :"tweets/edit"
    else
      redirect "/login"
    end
  end

  post '/tweets' do
    tweet = Tweet.new(content: params[:content], user_id: Helpers.current_user(session).id)
    if tweet.save
      redirect "/tweets"
    else
      redirect "/tweets/new"
    end
  end

  post '/tweets/:id/edit' do
    tweet = Tweet.find_by(id: params[:id])
    tweet.content = params[:content]
    if tweet.save
      redirect "/tweets"
    else
      redirect "/tweets/#{tweet.id}/edit"
    end
  end
  
  delete '/tweets/:id' do
    if Helpers.current_user(session) == Tweet.find_by(id: params[:id]).user
      tweet = Tweet.find_by(id: params[:id])
      tweet.destroy
    end
  end
end
