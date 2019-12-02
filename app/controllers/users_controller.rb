class UsersController < ApplicationController

  get '/' do
    erb :index
  end

  get '/signup' do
    
    if is_logged_in?(session)
      redirect to '/tweets'
    end

    erb :'users/create_user'
  end

  post '/signup' do
    params.each do |label, input|
      if input.empty?
        flash[:new_user_error] = "Please enter a value for #{label}"
        redirect to '/signup'
      end
    end
    user = User.create(:username => params["username"], :email => params["email"], :password => params["password"])
    session[:user_id] = user.id

    redirect to '/tweets'
  end
end
