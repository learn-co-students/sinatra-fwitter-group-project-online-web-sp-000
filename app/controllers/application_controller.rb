require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  get "/users/signup" do
    if Helpers.is_logged_in?(session)
      redirect to '/tweets'
    else
      erb :"/users/signup"
    end
  end

  post "/users/signup" do

    if Helpers.empty_input?(params)
      redirect to '/signup'
    else
      @user=User.create(params)
      session[:user_id]=@user.id
      redirect to '/tweets'
    end
  end


  get '/users/login' do
  #binding.pry
    if Helpers.is_logged_in?(session)
      redirect '/tweets'
    else
      erb :"/users/login"
    end
  end

  post '/users/login' do

    @user=User.find_by(:username=>params[:username])
    if @user && @user.authenticate(params[:password])
    session[:user_id] = @user.id
      redirect to '/tweets'
    else
      redirect to "users/login"
    end
  end

  get '/users/logout' do
    if Helpers.is_logged_in?(session)
      session.clear
      redirect to 'users/login'
    else
      redirect to '/'
    end
  end


end
