require './config/environment'

class TweetsController < ApplicationController
  configure do
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'secret'
  end

  get '/tweets' do
    if User.logged_in?(session)
      @user = User.current_user(session)
      @tweets = Tweet.all

      erb :'/tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if User.logged_in?(session)
      erb :'/tweets/new'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    if !User.logged_in?(session)
      redirect to '/login'
    end

    @tweet = Tweet.find_by(id: params[:id])
    @user = User.current_user(session)

    if @tweet.user.id = @user.id
      erb :'/tweets/edit_tweet'
    else
      redirect to '/tweets'
    end
  end

  get '/tweets/:id' do
    if User.logged_in?(session)
      @user = User.current_user(session)
      @tweet = Tweet.find_by(id: params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    if User.logged_in?(session)
      user = User.current_user(session)
      tweet = Tweet.new(content: params[:content])
      tweet.user = user
      if tweet.save
        redirect to "/tweets/#{tweet.id}"
      else
        redirect to '/tweets/new'
      end
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id/edit' do
    if User.logged_in?(session)
      user = User.current_user(session)
      tweet = Tweet.find_by(id: params[:id])

      if tweet && user.id == tweet.user.id
        tweet.content = params[:content]
        if !tweet.save
          redirect to "/tweets/#{tweet.id}/edit"
        end
      end
    end

    redirect to '/tweets'
  end

  delete '/tweets/:id/delete' do
    if User.logged_in?(session)
      user = User.current_user(session)
      tweet = Tweet.find_by(id: params[:id])

      if tweet && user.id == tweet.user.id
        tweet.destroy
      end
    end

    redirect to '/tweets'
  end
end