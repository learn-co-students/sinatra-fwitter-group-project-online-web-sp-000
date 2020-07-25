require './config/environment'
require 'sinatra/base'
class TweetsController < ApplicationController
   register Sinatra::ActiveRecordExtension
    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
        enable :sessions
        set :session_secret, "password_security"
    end

   get '/tweets' do
      if !Helpers.is_logged_in?(session)
         redirect to '/login'
      end
      @tweets = Tweet.all
      @user = Helpers.current_user(session)
      erb :'/tweets/tweets'
   end
end
