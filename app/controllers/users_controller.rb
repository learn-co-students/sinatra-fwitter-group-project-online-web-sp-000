class UsersController < ApplicationController
  
  get '/signup' do
    erb :'users/signup'
  end
  
  post '/signup' do
    @user = User.create(params)
    # binding.pry
    redirect :'/tweets'
  end

end
