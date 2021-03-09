require './config/environment'

class ApplicationController < Sinatra::Base

  require 'rack/flash'
  require 'sinatra/flash'
  require 'sinatra/redirect_with_flash'

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'mission_impossible'
    use Rack::Flash, :sweep => true
    register Sinatra::Flash
    register Sinatra::RedirectWithFlash
  end


  get '/' do
  	erb :'index'
  end

  helpers do
  	
  	def is_logged_in?(session)
  	  !!current_user(session)
  	end

  	def current_user(session)
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]	
  	end

    def login 
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        current_user(session)
      end
    end    

    def signup_error(user)
      errors = user.errors.messages
      i=0
      errors.each_pair do |k,v|
        flash[:error[i]] = "#{k.to_s} #{v.join}"
        i+=1
      end
      redirect "/signup"
    end     

  end

end
