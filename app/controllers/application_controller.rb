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
    erb :'users/signup'
  end

  post '/signup' do
   
    if params[:username] == ""
        redirect to '/signup'
    elsif params[:email] == ""
        redirect to '/signup'
    elsif params[:password] == ""
      redirect to '/signup'
    else
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])

      redirect to '/tweets'
    end

  end

  get '/tweets' do
    erb :'/tweets/new'
  end

  get '/login' do
    erb :'users/login'
  end 

  post '/login' do
    @user = User.find_by(username: params[:username], password: params[:password])

    if @user
      session[:user_id] = @user.id
      redirect to '/tweets'
    end

  end

end
