class TweetsController < ApplicationController

  get '/tweets' do
    if !!Helpers.is_logged_in?(session)
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect to ('/login')
    end
  end

  post '/tweets' do
    if params[:content] != ""
      @tweet = Tweet.create(content: params[:content], user: Helpers.current_user(session))
      @tweet.save
      redirect to ("/tweets/#{@tweet.id}")
    else
      redirect to ('/tweets/new')
    end
  end  

  patch '/tweets' do
    @tweet = Tweet.find(params[:id].to_i)
    @tweet.content = params[:content]
    @tweet.save
    if @tweet.content != ""      
      redirect to ("/tweets/#{@tweet.id}")
    else
      redirect to ("/tweets/#{@tweet.id}/edit")
    end
  end

  get '/tweets/new' do
    if !!Helpers.is_logged_in?(session)
      erb :'/tweets/new'
    else
      redirect to ('/login')
    end
  end

  get '/tweets/:id' do
    if !!Helpers.is_logged_in?(session)
      @tweet = Tweet.find(params[:id].to_i)
      erb :'tweets/show_tweet'
    else
      redirect to ('/login')
    end
  end

  get '/tweets/:id/edit' do
    if !!Helpers.is_logged_in?(session)
      @tweet = Tweet.find(params[:id].to_i)
      erb :'tweets/edit_tweet'
    else
      redirect to ('/login')
    end
  end

  get '/tweets/:id/delete' do
    if !!Helpers.is_logged_in?(session)
      Tweet.delete(params[:id].to_i)      
      redirect to ('/tweets')
    else
      redirect to ('/login')
    end
  end
end
