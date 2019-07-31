class UsersController < ApplicationController

  get '/signup' do
    erb :'users/new'
  end  

  post '/signup' do
    @user = User.new(params)
    if @user.save 
      flash[:message] = "Welcome to Flat Iron Twiter!!!"
      redirect to "/tweets"
    else
      redirect to '/signup'
    end
  end
end
