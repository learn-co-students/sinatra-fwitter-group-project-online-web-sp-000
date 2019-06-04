require './config/environment'

class ApplicationController < Sinatra::Base
  enable :sessions

  def current_user(session)
    if session[:user_id] != nil
      @current_user = User.all.find_by_id(session[:user_id])
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
    session[:user_id] = @user.id
    
    redirect "/tweets"
  end

  get '/login' do

  erb :'users/login'
  end

  post '/login' do

  erb :'/tweets/index'
  end

  get '/tweets' do

  end

end
