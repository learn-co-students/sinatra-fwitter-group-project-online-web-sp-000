class UsersController < ApplicationController
  
  get '/signup' do
    if !logged_in?
      erb :'users/signup'
    else
      redirect :'/tweets'
    end
  end
  
  post '/signup' do
    if params.values.any? { |value| value == "" }
      redirect :'/signup'
    else
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect :'/tweets'
    end
  end

end
