class TweetsController < ApplicationController

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/tweets" do
    if session.has_key?(:id)
      @user = User.find(session[:id])
      erb :'tweets/tweets'
    else
      redirect to "/login"
    end
  end

end
