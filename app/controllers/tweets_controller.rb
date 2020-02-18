class TweetsController < ApplicationController

  get "/tweets" do
    # binding.pry
    if !Helper.is_logged_in?(session)
      redirect "/login"
    end
    @user = Helper.current_user(session)
    @tweets = Tweet.all
    erb :"tweets/index"
  end

  get '/tweets/new' do
    if !Helper.is_logged_in?(session)
      redirect "/login"
    end
    erb :"tweets/new"
  end

  post '/tweets' do
    if params[:content] != ""
      tweet = Tweet.create(params)
      Helper.current_user(session).tweets << tweet
    else
      redirect "/tweets/new"
    end
    redirect "/users/show"
  end

  get "/tweets/:id" do
    if !Helper.is_logged_in?(session)
      redirect "/login"
    end
    @tweet = Tweet.find_by(params)
    erb :"tweets/show"
  end

  get "/tweets/:id/edit" do
    if !Helper.is_logged_in?(session) || Helper.current_user(session).id != Tweet.find_by(params).user_id
      redirect "/login"
    end
    @tweet = Tweet.find_by(params)
    erb :"tweets/edit"
  end

  patch "/tweets/:id" do
    tweet = Tweet.find_by_id(params[:id])
    if params[:tweet][:content] == ""
      redirect "/tweets/#{tweet.id}/edit"
    end
    tweet.update(params[:tweet])
    redirect "/tweets/#{tweet.id}"
  end

  delete "/tweets/:id" do
    if !Helper.is_logged_in?(session) || Helper.current_user(session).id != Tweet.find_by_id(params[:id]).user_id
      redirect "/login"
    end
    Tweet.find_by_id(params[:id]).destroy
    redirect "/tweets"
  end
end
