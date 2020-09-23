class UsersController < ApplicationController

    get '/users' do
        erb :index  
    end

    get '/users/:slug' do 
        @user = User.find_by_slug(params[:slug])
        @tweets = Tweet.all.filter{|tweet| tweet.user_id == @user.id}
        erb :"users/show"
    end

end
