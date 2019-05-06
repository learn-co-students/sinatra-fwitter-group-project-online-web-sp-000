require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :signup
    end
  end

  post '/signup' do
    #binding.pry
    if valid_signup?
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/tweets' do
    @user = User.find(session[:user_id])
    erb :tweets
  end

  get '/tweets/new' do
  end

  post '/tweets' do
    @tweet = Tweet.create(params)
    erb :'tweets/show'
  end

  get '/tweets/:id' do
    erb :'tweets/show'
  end


  helpers do
    def valid_signup?
      if params[:username] != "" &&  params[:email] != "" && params[:password] != "" && params[:username] && params[:email] && params[:password]
        true
      else
        false
      end
    end

    def logged_in?
      !!session[:user_id]
    end
  end

end
