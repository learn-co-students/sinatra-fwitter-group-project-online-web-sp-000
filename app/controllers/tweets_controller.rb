class TweetsController < ApplicationController

  get '/tweets' do
    if is_logged_in?(session)
      @all_tweets = Tweet.all
      @all_users = User.all

      erb :'tweets/index'
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    if is_logged_in?(session)
      erb :'tweets/new'
    else
      redirect "/login"
    end
  end

  post '/tweets' do
    @tweet = Tweet.new(content: params[:content])
    @tweet.user = current_user

    if @tweet.save
      redirect '/tweets'
    else
      session[:error_message] = "Error: you cannot create a tweet without content."
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if is_logged_in?(session)
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show'
    else
      redirect "/login"
    end
  end

  get '/tweets/:id/edit' do
    if is_logged_in?(session)
      @tweet = Tweet.find(params[:id])

      if @tweet.user.id == current_user.id
        erb :'tweets/edit'
      else
        redirect "/tweets"
      end
    else
      redirect "/login"
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])

    if params[:content].empty?
      redirect "/tweets/#{@tweet.id}/edit"
    else
      @tweet.update(content: params[:content])
    end

    redirect "/tweets/#{@tweet.id}"
  end

  helpers do

    def is_logged_in?(session)
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

  end

end
