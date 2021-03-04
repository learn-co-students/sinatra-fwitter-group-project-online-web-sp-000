class TweetsController < ApplicationController
  get '/tweets' do
    erb :'tweets/tweets'
  end

  # post '/tweets' do
  #   @user = User.find_by(:username => params[:username])
  #
  #     if @user
  #       session[:user_id] = @user.id
  #       erb :'tweets/tweets'
  #       redirect to '/'
  #     else
  #       erb :error
  #     end
  #   end

end
