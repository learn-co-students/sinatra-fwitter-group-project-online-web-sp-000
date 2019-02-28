class TweetsController < ApplicationController


  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect "/login"
    end
  end

  post '/tweets' do
    if logged_in?
      if params[:content] != ""
        @tweet = Tweet.new(content: params[:content], user_id: current_user.id)
        @tweet.save
        redirect "/tweets"
      else
        redirect "/tweets/new"
      end
    else
      redirect "/login"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      erb :'tweets/show_tweet'
    else
      redirect "/login"
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      erb :'tweets/edit_tweet'
    else
      redirect "/login"
    end
  end

  patch '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      if params[:content] != ""
        @tweet.update(content: params[:content], user_id: current_user.id)
        redirect "/tweets/#{@tweet.id}"
      else
        redirect "/tweets/#{@tweet.id}/edit"
      end
    else
      redirect "/login"
    end
  end

  delete '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      if @tweet.user == current_user
        @tweet.destroy
        redirect "/tweets"
      else
        redirect "/login"
      end
    else
      redirect "/tweets"
    end
  end

end
