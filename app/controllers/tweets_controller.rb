class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    if logged_in?
        @tweet = current_user.tweets.build(content: params[:content])
        if @tweet.save
            redirect to "/tweets/#{@tweet.id}"
        else
            redirect to "/tweets/new"
        end
    else
        redirect to '/login'
    end
  end

  get '/tweets/:id' do
    if logged_in?
        @tweet = Tweet.find(params[:id])
        erb :'tweets/show'
    else
        redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
        @tweet = Tweet.find(params[:id])
        if @tweet
            erb :'tweets/edit'
        else
            redirect to '/tweets'
        end
    else
        redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    if logged_in?
        @tweet = Tweet.find(params[:id])
        if @tweet.update(content: params[:content])
            redirect to "/tweets/#{@tweet.id}"
        else
            redirect to "/tweets/#{@tweet.id}/edit"
        end
    else
        redirect to '/login'
    end
  end

  delete '/tweets/:id' do
    if logged_in?
        @tweet = Tweet.find(params[:id])
        if @tweet.user == current_user
            @tweet.destroy
            redirect to '/tweets'
        end
    else
        redirect to '/tweets'
    end
  end

end
