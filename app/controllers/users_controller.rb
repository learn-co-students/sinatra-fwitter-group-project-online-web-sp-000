class UsersController < ApplicationController

  
  get '/users/:slug' do
    @tweets = User.find_by_slug(params[:slug]).tweets
    erb :"users/show"
  end



end
