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

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'show_tweets'
  end
end
