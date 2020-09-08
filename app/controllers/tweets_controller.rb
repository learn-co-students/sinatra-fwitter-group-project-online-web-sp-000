class TweetsController < ApplicationController
use Rack::Flash

  get '/tweets' do
    #binding.pry
    @user = current_user
    @tweets = Tweet.all
    if !logged_in?
      redirect "/login"
    else
      erb :'tweets/tweets'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect "/login"
    end
  end

  post '/tweets/new' do
    #binding.pry
    if params[:content] == nil || params[:content] ==" " || params[:content] == ""
      flash[:message] = "Please create a tweet with content!"
      redirect "/tweets/new"
    else
      @tweet = Tweet.new(content: params["content"], user_id: session[:user_id])
      @tweet.save
      redirect "/tweets/new"
    end
  end

  get '/tweets/:id/edit' do
    #binding.pry
    @tweet = Tweet.find_by(id: params[:id])
    if logged_in?
      if @tweet.user_id == current_user.id
        erb :'tweets/edit_tweet'
      else
        redirect "/tweets"
      end
    else
      redirect "login"
    end
  end

  patch '/tweets/:id' do
    #binding.pry
    if params[:content]== "" || params[:content] == nil || params[:content] == " "
      flash[:message] = "You cannot update a tweet to be blank."
      redirect "/tweets/#{params[:id]}/edit"
    else
      @tweet = Tweet.find_by(id: params[:id])
      @tweet.update(content: params[:content])
    end
  end

  get '/tweets/:id' do
    #binding.pry
    @tweet = Tweet.find_by(id: params[:id])
    if logged_in?
      erb :'tweets/show_tweet'
    else
      redirect "/login"
    end
  end

  delete '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      if current_user.id == @tweet.id
        @tweet.delete
      else
        redirect "/tweets"
      end
    else
      redirect "/login"
    end
  end


end
