class UsersController < ApplicationController

  get '/' do
    erb :"users/index"
  end


end
