require './config/environment'

class ApplicationController < Sinatra::Base
  enable :sessions

  def current_user(session)
    if session[:user_id] != nil
      @current_user = User.find(session[:user_id])
    end
  end

  def logged_in?(session)
    !!session[:user_id]
  end

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end



  get '/' do

  erb :index
  end

  get '/signup' do
    if logged_in?(session)
      redirect to '/tweets'
    end

    erb :'/users/create'
  end

  post '/signup' do
    @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
    # binding.pry
    session[:user_id] = @user.id
    redirect "/tweets"
  end

  get '/login' do
    if logged_in?(session)
      redirect '/tweets'
    else
      erb :'users/login'
    end
  end

  get '/logout' do
    if logged_in?(session)
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end



  post '/login' do
    @user = User.all.find_by(:username => params[:username])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      # flash[:user_error] = "Incorrect Login.  Please try Again!"
      redirect '/login'
    end
  end
end
