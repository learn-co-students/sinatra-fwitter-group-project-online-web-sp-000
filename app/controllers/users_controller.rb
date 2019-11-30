class UsersController < ApplicationController

    get '/login' do
        if logged_in?
            redirect '/tweets'
        else
            erb :'/users/login'
        end
    end
    
    get '/signup' do
        if logged_in?
            redirect '/tweets'
        else
            erb :'/users/signup'
        end
    end
      
    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        tweets = Tweet.all
        @user_tweets = []
        tweets.each do |tweet|
            if tweet.user_id == @user.id
                @user_tweets << tweet
            end
        end
        erb :'/users/show'
    end
    
    post '/signup' do
        user = User.new(username: params[:username], email: params[:email], password: params[:password])
        if (user.username != "") && (user.email != "") && (user.password != "") && (user.save)
            session[:user_id] = user.id
            redirect '/tweets'
        else
            redirect '/signup'
        end
    end
    
    post '/login' do
        user = User.find_by(username: params[:username])
        if (user.username != "") && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect '/tweets'
        else
            redirect '/login'
        end
    end
    
    get '/logout' do
        session.clear
        redirect "/login"
    end

end #end of UsersController