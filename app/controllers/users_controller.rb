class UsersController < ApplicationController

    # get '/users/:slug' do
    #     @user = User.find_by_slug(params[:slug])
    #     erb :'users/show'
    # end

    get '/users/:id' do
        @user = User.find(params[:id])
        erb :'users/show'
    end



end
