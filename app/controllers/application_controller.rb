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

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else  
      @message = current_message
      erb :signup
    end
  end

  post '/signup' do
    check_params(params, 'signup')
    new_user = User.create(params)
    session.clear
    set_session_id(new_user)
    redirect '/tweets'
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      @message = current_message
      erb :login
    end
  end

  post '/login' do
    check_params(params, 'login')
    if user = User.find_by(username: params[:username])
      if user.authenticate(params[:password])
        session.clear
        set_session_id(user)
        redirect '/tweets'
      else
        set_session_message("Incorrect Password")
        redirect '/login'
      end
    else
      set_session_message("Incorrect Username")
      redirect '/login'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/login' 
    else
      session.clear
      redirect '/login'
    end
    
  end

  helpers do

    def check_params(params, current_page)

      params.each do |k, v|
        if v.empty?
          set_session_message("#{k.to_s.capitalize} can not be left empty")
          redirect "/#{current_page}"
        end
      end
      
    end

    def logged_in?
      if session[:id]
        true
      else
        false
      end
    end

    def current_user
      if logged_in?
        id = session[:id]
        user = User.find(id)
        user
      end
    end

    def set_session_id(user)
      session[:id] = user.id
    end

    def has_message?
      if session[:message]
        true
      else
        false
      end
    end

    def current_message
      if has_message?
        session[:message]
      end
    end

    def set_session_message(message)
      session[:message] = message
    end

  end
end
