class UsersController < ApplicationController

    configure do
		set :views, "app/views"
		enable :sessions
		set :session_secret, "password_security"
    end
    
    get '/' do
        erb :'index'
    end

    get '/signup' do
        #binding.pry
        
        if Helpers.is_logged_in?(session)
            
            redirect to "/tweets"
        else
            
            erb :'signup'
        end

    end

    post '/signup' do
        if Helpers.is_logged_in?(session)

            redirect to "/tweets"
        end

        user = User.new(username: params[:username], email: params[:email], password: params[:password])
        
        
        
        if user.save
            session[:user_id] = user.id
            redirect to '/tweets'

        else
            redirect to '/signup'
        end
        

    end



    get '/login' do
        #binding.pry
        if logged_in?
            redirect "/tweets"
        else
            erb :'users/login'
        end     
    end

    post '/login' do
        #binding.pry
        if logged_in?
            redirect "/tweets"
        end

        user = User.find_by(:username => params[:username])

        if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          
          redirect "/tweets"
        else
          redirect "/failure"
        end
    end

    get '/logout' do
        session.clear
        redirect to "/login"
    end

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        @tweets = Tweet.all.select do |tweet|
            tweet.user_id == @user.id
        end
        
        erb :'users/show'
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
