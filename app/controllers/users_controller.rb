class UsersController < ApplicationController

  get '/signup' do
    erb :'/users/create_user'
  end

  post '/signup' do
    @user = User.new(uername: params[:username], email: params[:email], password: params[:password])

    if params[:username] && params[:password]
    redirect :'/tweets'
  end

end
