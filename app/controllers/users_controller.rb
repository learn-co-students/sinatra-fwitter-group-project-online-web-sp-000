class UsersController < ApplicationController

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :'/users/show'
    end

    get '/signup' do
        #directs user to the create user page if they are new; does not let a logged in user view the signup page
        if !logged_in?
            erb :'users/create_user'
        else
            redirect to '/tweets'
        end
    end

    post '/signup' do
        #checks to make sure user entered all required information and redirects to create_user if they didn't
        #creates user with info from params hash and uses the session id as the user id
        #redirects the new user to the main tweets page
        if params[:username] == "" || params[:email] == "" || params[:password] == ""
            redirect to '/signup'
        else
            @user = User.create(username: params[:username], email: params[:email], password: params[:password])
            session[:user_id] = @user.id
        end
        redirect to "/tweets"
    end

    get '/login' do
        #loads the login page if the user is not logged in, and loads the tweets page if they are
        if !logged_in?
            erb :'/users/login'
        else
            redirect to '/tweets'
        end
    end

    post '/login' do
        #find user by username
        user = User.find_by(username: params[:username])
        #if user is authenticated, redirect to tweets index, if not, redirect to signup
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect to '/tweets'
        else 
            redirect to '/signup'
        end
    end

    get '/logout' do
        if logged_in?
            session.destroy
            redirect to '/login'
        else
            redirect to '/'
        end
    end


end
