class UsersController < ApplicationController

  get '/signup' do
    erb :"users/create_user"
  end

  post '/signup' do
    params.each do |label, input|
      if input.empty?
        flash[:new_user_error] = "Please fill in #{label}."
        redirect '/signup'
      end
    end
     @user = User.create(username: params["username"], email: params["email"], password: params["password"])
     session[:user_id] = @user.id
     redirect "/tweets"
  end

  get '/login' do
    if Helpers.is_logged_in?(session)
      redirect to '/tweets'
    end
  end




end
