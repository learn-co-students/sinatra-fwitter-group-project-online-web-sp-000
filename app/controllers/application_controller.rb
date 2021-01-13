require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    @session = session
    erb :index
  end

  get '/signup' do
    if Helpers.is_logged_in?(session)
      redirect to '/tweets/index'
    else
      erb :signup
    end
  end

  post '/signup' do
    if ((params[:username] != "") && (params[:email] != "") && (params[:password] != ""))
      @user = User.create(username: params[:username], email: params[:email], password_digest: params[:password])
      session[:user_id] = @user.id
      redirect to '/tweets/index'
    else
      redirect to '/signup'
    end
  end

  get '/login' do
    if Helpers.is_logged_in?(session)
      redirect to '/tweets'
    else
      erb :'users/login'
    end
  end

  post "/login" do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end



end
