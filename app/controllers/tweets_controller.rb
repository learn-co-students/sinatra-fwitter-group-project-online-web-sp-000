class TweetsController < ApplicationController
    configure do
        set :views, "app/views"
        enable :sessions
        set :session_secret, "password_security"
      end

get "/tweets" do
    @user=User.find_by_id(session[:id])
    erb :'/tweets/index'
end


end
