class UsersController < ApplicationController
  get '/users/:slug' do
    @user = User.find_by_slug(slug)
    erb :'users/show'
  end
end
