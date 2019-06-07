require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  def current_user(session)
    if session[:user_id] != nil
      @current_user = User.find(session[:user_id])
    end
  end

  def logged_in?(session)

    !!session[:user_id]
  end

  post '/tweets/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    if !logged_in?(session)
      redirect '/login'
    end

    if current_user(session).id != @tweet.user.id
      redirect "/tweets"
    end

    @tweet.delete
    redirect '/tweets'
  end


  get '/' do

  erb :index
  end

end
