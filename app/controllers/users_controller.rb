class UsersController < ApplicationController

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :'users/show'
      end
    get "/signup" do
        
        if !logged_in?
            erb :'/users/signup'
          else
            redirect to '/tweets'
        end
    end
    post '/signup' do
        
        if params[:username] == "" || params[:email] == "" || params[:password] == ""
            redirect '/users/signup'
        else
            #binding.pry
            @user = User.create(username: params[:username], password: params[:password])
            session[:user_id] = @user.id
            redirect '/tweets'
        end
    end
    get '/login' do
        if !logged_in?
            erb :'users/login'
          else
            redirect to '/tweets'
        end
    end
    post '/login' do
        #here we need to find the user with a given username
        #if there is such a user, we need to doublecheck it's password
        #if the password is ok and user exists, the new session starts
        #whose id is the same as users id
        @user = User.find_by(:username => params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect to '/tweets'
        else
            redirect "/users/signup"
        end
    end
    
    get "/logout" do
        if logged_in?
            session.destroy
            redirect to '/login'
        else
            redirect to '/'
        end
    end

end
