class UsersController < ApplicationController
    
 get "/users/:slug" do 
   @user =  User.find_by(username: params[:slug])
       erb :'tweets/show_tweet'
   end

end
