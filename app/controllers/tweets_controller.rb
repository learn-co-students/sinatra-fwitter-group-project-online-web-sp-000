class TweetsController < ApplicationController

    get '/tweets/new' do
      erb :new
    end

    post '/tweets' do

    end

    get '/tweets' do
      if logged_in?
        @user = User.find_by(session[:user_id])
        @tweets = @user.tweets
        erb :"tweets/tweets"
      else
        redirect '/login'
      end
    end

    helpers do
      def logged_in?
        !!session[:user_id]
      end

      def current_user
        User.find(session[:user_id])
      end
    end
end
