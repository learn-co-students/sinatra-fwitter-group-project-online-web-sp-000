class TweetsController < ApplicationController
  get '/tweets' do
    if session[:user_id] == nil
      redirect to '/login'
    else
      erb :'/tweets/tweets'
    end
  end

  get '/tweets/new' do
    if session[:user_id] == nil
      redirect to '/login'
    else
      erb :'/tweets/new'
    end
  end

  post '/tweets' do
    if params[:content] != ""
      @tweet = Tweet.create(:content => params[:content],
        :user_id => session[:user_id])
      redirect to '/tweets'
    else
      redirect to '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if session[:user_id] == nil
      redirect to '/login'
    else
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    end
  end

  get '/tweets/:id/edit' do
    if session[:user_id] == params[:id].to_i
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/edit_tweet'
    else
      redirect to '/login'
    end
  end

  post '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if params[:content] != ""
      @tweet.content = params[:content]
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to "/tweets/#{@tweet.id}/edit"
    end
  end

  post '/tweets/:id/delete' do
    if session[:user_id] == params[:id].to_i
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.delete
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end

end
