class TweetsController < ApplicationController

  get '/tweets' do
    @tweets = Tweet.all
    #binding.pry
    if Helpers.is_logged_in?(session)
      @user = User.find(session[:user_id])
      erb :'/tweets/index'
    else
      redirect to '/users/login'
    end

  end

  get '/tweets/new' do
    if Helpers.is_logged_in?(session)
      erb :'tweets/new'
    else
      redirect to '/users/login'
    end
  end

  post '/tweets' do
    @tweets = Tweet.all
    if !params[:content].empty?
      @tweet = Tweet.create(:content=>params[:content])
      @user=User.find(session[:user_id])
      @user.tweets << @tweet
      redirect "/tweets"
    else
      redirect '/tweets/new'
    end
  end


  get '/tweets/:id' do
    if Helpers.is_logged_in?(session)
        @tweet = Tweet.find(params[:id])
        erb :'tweets/show'
      else
        redirect to '/users/login'
      end
  end

  get '/tweets/:id/edit' do

      @tweet = Tweet.find(params[:id])
      if Helpers.is_logged_in?(session) && Helpers.current_user(session)==@tweet.user
        erb :'tweets/edit'
      else
        redirect to '/users/login'
      end
  end

  patch '/tweets/:id' do
   @tweet = Tweet.find_by_id(params[:id])
   if @tweet
      unless params[:content].empty?
      @tweet.update(:content=>params[:content])
        redirect to '/tweets'
      else
        redirect "/tweets/#{@tweet.id}/edit"
      end
    end
  end

  delete '/tweets/:id' do
      @tweet=Tweet.find(params[:id])
      if @tweet && Helpers.current_user(session)==@tweet.user
        @tweet.delete(params[:id])
      redirect to "/tweets"
      else
        redirect to "users/login"
      end
  end

end
