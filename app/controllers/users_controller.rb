require 'rack-flash'
class UsersController < ApplicationController
    use Rack::Flash

    get "/signup" do
        erb :'users/create_user'
    end
    
    post "/signup" do
        @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
        if(@user.valid?)
            @user.save
            session[:user_id] = @user.id
            redirect "/tweets"
        else
            flash[:message] = @user.errors.full_messages
            redirect "/signup"
        end
    end
end
