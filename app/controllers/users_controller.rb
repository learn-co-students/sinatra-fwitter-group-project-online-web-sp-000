require 'rack-flash'
class UsersController < ApplicationController
    use Rack::Flash

    get "/signup" do
        if(!logged_in?)
            erb :'users/create_user'
        else
            redirect "/tweets"
        end 
    end
    
    post "/signup" do
        @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
        if(@user.valid?)
            if(@user.save)
                session[:user_id] = @user.id
                redirect "/tweets"
            end
        else
            flash[:message] = @user.errors.full_messages
            redirect "/signup"
        end
    end

    get "/login" do
        if(!logged_in?)
            erb :'users/login'
        else
            redirect "/tweets"
        end
    end
    
    post "/login" do
        @user = User.find_by(:username => params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect "/tweets"
        else
            redirect "/login"
        end
    end
    
    get "/logout" do
        session.clear
        redirect "/login"
    end

end
