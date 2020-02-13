class TweetsController < ApplicationController

  get '/tweets' do
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      erb :'/tweets/index'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      erb :'/tweets/new'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    if !Helpers.is_logged_in?(session)
      redirect to '/login'
    end
    @user = Helpers.current_user(session)
    @tweet = Tweet.new(content: params["content"], user_id: @user.id)
    if @tweet.valid?
      @tweet.save
      redirect to '/tweets'
    else
      flash[:message] = "No Content"
      redirect to '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if !Helpers.is_logged_in?(session)
      redirect to '/login'
    end
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/show'
  end

  get '/tweets/:id/edit' do
    if !Helpers.is_logged_in?(session)
      redirect to '/login'
    end
    @tweet = Tweet.find(params[:id])
    if @tweet.user == Helpers.current_user(session)
        erb :'/tweets/edit'
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])

    if params[:content].empty?
      redirect to "/tweets/#{@tweet.id}/edit"
    end

    @tweet.update(content: params["content"])
    @tweet.save
    redirect to "/tweets/#{@tweet.id}"

  end

  delete '/tweets/:id/delete' do
    if Helpers.is_logged_in?(session)
      @tweet = Tweet.find(params[:id])
      if @tweet.user == Helpers.current_user(session)
        @tweet = Tweet.find_by_id(params[:id])
        @tweet.delete
        redirect to '/tweets'
      else
        redirect to '/tweets'
      end
    else
      redirect to '/login'
    end
  end

end