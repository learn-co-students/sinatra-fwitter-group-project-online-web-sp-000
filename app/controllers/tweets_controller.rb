class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if logged_in?
      if params[:content] ==""
        redirect to "/tweets/new"
      else
        @user = User.find_by_id(session[:user_id])
        @tweet = current_user.tweets.build(content: params[:content])
          if @tweet.save
            redirect to "/tweets/#{@tweet.id}"
          else
            redirect to "/tweets/new"
          end
        end
      else
        redirect to "/login"
      end
      end
  end



  get '/tweets/new' do
    erb :'tweets/new'
  end

  # post '/tweets' do
  #   tweet = Tweet.new(:content => params[:content]) #(:user_id => params[:user_id])
  #   if tweet.save
  #     erb :'tweets/tweets'
  #   else
  #     redirect '/tweets/new'
  #   end
  # end
  # post '/tweets' do
  #   @user = User.find_by(:username => params[:username])
  #
  #     if @user
  #       session[:user_id] = @user.id
  #       erb :'tweets/tweets'
  #       redirect to '/'
  #     else
  #       erb :error
  #     end
  #   end

end
