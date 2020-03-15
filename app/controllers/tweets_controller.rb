class TweetsController < ApplicationController
  get "/tweets" do
    if session[:user_id]
      erb :'/tweets/index'
    else
      redirect "/login"
    end
  end

  get "/tweets/new" do
    if session[:user_id]
      erb :'/tweets/new'
    else
      redirect "/login"
    end
  end

  post "/tweets" do
    if params[:content].size > 0
      @tweet = Tweet.create(user_id: session[:user_id], content: params[:content])
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/new"
    end
  end

  get "/tweets/:id" do
    if session[:user_id]
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show'
    else
      redirect "/login"
    end
  end

  get "/tweets/:id/edit" do
    redirect "/login" if session[:user_id].nil?
    @tweet = Tweet.find(params[:id])
    if session[:user_id] == @tweet.user_id
      erb :'/tweets/edit'
    end
  end

  patch "/tweets/:id" do
    @tweet = Tweet.find(params[:id])
    if session[:user_id] == @tweet.user_id && params[:content].size > 0
      @tweet.update(content: params[:content])
      redirect "/tweets/#{params[:id]}"
    end
    redirect "/tweets/#{params[:id]}/edit"
  end

  delete "/tweets/:id" do
    @tweet = Tweet.find(params[:id])
    if session[:user_id] == @tweet.user_id
      @tweet.destroy
      redirect "/tweets"
    end
    redirect "/tweets/#{params[:id]}"
  end
end
