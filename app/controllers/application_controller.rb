require './config/environment'
require 'rack-flash'


class ApplicationController < Sinatra::Base

  enable :sessions
  use Rack::Flash

  configure do
    set :session_secret, "glyyph"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/signup' do

    if Helpers.is_logged_in?(session)
      redirect to '/tweets'
    end

    erb :'users/new_user'

  end

  post '/signup' do

    params.each do |param, input|
      if input.empty?
        flash[:new_user_error] = "Please enter a value for #{param}"
        redirect to '/signup'
      end
    end

    user = User.create(:username => params["username"], :email => params["email"], :password => params["password"])
    session[:user_id] = user.id

    redirect to '/tweets'

    end

    get '/login' do

    if Helpers.is_logged_in?(session)
      redirect to '/tweets'

    end

    erb :"/users/login"

    end

    post '/login' do

    user = User.find_by(:username => params["username"])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/tweets'
    else
      flash[:login_error] = "Incorrect login. Please try again."
      redirect to '/login'
    end

    end

    get '/tweets' do

    if !Helpers.is_logged_in?(session)
      redirect to '/login'
    end

    @tweets = Tweet.all
    @user = Helpers.current_user(session)
    erb :"/tweets/tweets"

  end

end
