class UsersController < ApplicationController

    get "/users/:slug" do
        @user = User.find_by_slug(params[:slug])
        erb :'/users/show'
    end

    get "/signup" do
        if is_logged_in?
         redirect to '/tweets'
        else
         erb :signup
        end
       end
     
    post "/signup" do
        @user = User.new(:email => params[:email], :username => params[:username], :password => params[:password])
            if @user.username != "" && @user.email != "" && @user.password != "" && @user.password_digest
                @user.save
                session[:user_id] = @user.id  
                redirect to '/tweets'
            else
                redirect to '/signup'
        end
    end

    get "/login" do
        if is_logged_in?
            redirect to '/tweets'
        else   
            erb :login  
        end 
    end

    post "/login" do
        @user = User.find_by(:username => params[:username])
            if @user.username && @user.authenticate(params[:password])
             session[:user_id] = @user.id
                redirect to '/tweets'
            else
                redirect to '/login'
            end
        end 

    get "/logout" do 
        if is_logged_in?
            session.clear
            redirect to '/login'
        else
            redirect to '/'
        end
    end
end
