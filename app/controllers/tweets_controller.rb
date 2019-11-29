class TweetsController < ApplicationController

  get '/tweets' do
    if sessin[:user_id]
      erb :"tweets/index"
    else
      redirect "/login"
    end
  end

  post "/tweet" do
    user = User.find_by(:user_id => session[:user_id])
    tweet = Tweet.new(:user => user, :status => params[:status])
    tweet.save
    redirect '/'
  end

end
