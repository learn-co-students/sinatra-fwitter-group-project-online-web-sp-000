class UsersController < ApplicationController

    get "/signup" do
        if !logged_in?
            erb :'users/create_user'
        else
            redirect to '/tweets'
        end
    end
    
    post "/signup" do
        if params[:username].empty? || params[:password].empty? || params[:email].empty?
            redirect to '/signup'
        else
            @user = User.new(username: params[:username], password: params[:password], email: params[:email])
            @user.save
            session[:id] = @user.id
            redirect to '/tweets'
        end
    end


    get "/login" do
        if !logged_in?
            erb :'users/login'
        else
            redirect to '/tweets'
        end
    
    end

    post "/login" do
    @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
            session[:id] = @user.id
            redirect to '/tweets'
        else
            redirect to '/login'
        end
    end

    get "/logout" do
        if logged_in?
            session.clear

            redirect to "/login"
        else
            redirect to '/'
        end
    end

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        
        erb :'users/show'
    end

end
