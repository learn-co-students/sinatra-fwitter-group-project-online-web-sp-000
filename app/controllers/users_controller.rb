class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'/users/signup'
    else
      redirect to '/tweets'
    end
  end

  post '/signup' do
    @user = User.create(params)
    session[:user_id] = @user.id
    redirect to '/tweets'
  end

end
