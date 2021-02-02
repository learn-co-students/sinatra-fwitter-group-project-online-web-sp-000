class UsersController < ApplicationController
  
    get '/signup' do
        if Helpers.is_logged_in?(session)
            redirect to '/tweets'
        else
            erb :"/users/create_user"
        end
    end

    post '/signup' do
        user = User.new(username: params[:username], email: params[:email], password: params[:password])
        if user.save
            session[:user_id] = user.id
            redirect to '/tweets'
        else
            redirect to '/signup'
        end
    end

    get '/login' do
        if Helpers.is_logged_in?(session)
            redirect to '/tweets'
        else
            erb :"/users/login"
        end
    end

    post '/login' do
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect to '/tweets'
        else
            redirect to '/login'
        end
    end

    get '/logout' do
        if Helpers.is_logged_in?(session)
            session.clear
            redirect to '/login'
        else
            redirect to '/'
        end
    end

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        if @user
            @tweets = @user.tweets
            erb :'/users/show'
        else
            redirect to '/signup'
        end
    end

end
