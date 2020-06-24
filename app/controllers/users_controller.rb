require 'pry'
class UsersController < ApplicationController
    configure do
        set :views, "app/views"
        enable :sessions
        set :session_secret, "password_security"
      end

get "/signup" do 
    erb :'/users/signup'
end

post "/signup" do 
    if !params["username"].empty? && !params["email"].empty? && !params["password"].empty?
        user=User.new(username: params["username"], email: params["email"], password_digest: params["password"])
        user.save
        session[:id]=user.id
        redirect "/tweets"
    else
        redirect "/signup"
    end
end

get "/login" do 
    erb :'/users/login'
end

post "/login" do
    @user = User.find_by(username: params["username"])
    session[:id]=@user.id
    redirect "/tweets"
end


end
