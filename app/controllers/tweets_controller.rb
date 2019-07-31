class TweetsController < ApplicationController
  get '/tweets' do
    if Helpers.is_logged_in?(session)
      @tweets = Tweet.all
      erb :'/tweets/index'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    erb :'/tweets/new'
  end

  get '/tweets/:id' do
    #binding.pry
    if Helpers.is_logged_in?(session)
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    if !params[:content].empty?
      @tweet = Tweet.create(content: params[:content])
      @tweet.user_id = Helpers.current_user(session).id
      @tweet.save
    else
      redirect to '/tweets/new'
    end
    #binding.pry
    redirect to "/tweets/#{@tweet.id}"
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    if Helpers.is_logged_in?(session)
      erb :'/tweets/edit'
    else
      redirect_to '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if params[:content].empty?
      redirect to "/tweets/#{@tweet.id}/edit"
    else
      @tweet.content = params[:content]
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.delete
    redirect to '/tweets'
  end

end
