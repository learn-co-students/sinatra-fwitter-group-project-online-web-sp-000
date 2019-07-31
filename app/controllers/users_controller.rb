class UsersController < ApplicationController

  get '/signup' do
    if !Helpers.is_logged_in?(session)
      erb :'users/new'
    else
      redirect to "/tweets"
    end
  end  

  post '/signup' do
    @user = User.new(params)

    if @user.save
      Helpers.log_in(@user, session)
      redirect to "/tweets"
    else
      redirect to '/signup'
    end
  end
end
