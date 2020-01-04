class TweetsController < ApplicationController

  get '/tweets' do
    @tweets = Tweet.all
    if Helpers.is_logged_in?(session)
      @user = User.find(session[:user_id])
      erb :'/tweets/index'
    else
      redirect to '/users/login'
    end
  end

  get '/tweets/new' do
    if Helpers.is_logged_in?(session)
      erb :'tweets/new'
    else
      redirect to '/users/login'
    end
  end

  post '/tweets' do
    @tweets = Tweet.all
    if !params[:content].empty?
      @tweet = Tweet.create(:content => params[:content])
      @user = User.find(session[:user_id])
      @user.tweets << @tweet
      redirect '/tweets'
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if Helpers.is_logged_in?(session)
    @tweet = Tweet.find(params[:id])
        erb :'/tweets/show'
    else
        redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
     if Helpers.is_logged_in?(session) && Helpers.current_user(session) == @tweet.user
        erb :'/tweets/edit'
      else
          redirect '/login'
     end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
      if !params[:content].empty?
        @tweet.update(:content => params[:content])
        #binding.pry
        redirect to "/tweets/#{@tweet.id}"
      else
        redirect to "/tweets/#{@tweet.id}/edit"
      end
    end


  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if @tweet && Helpers.current_user(session) == @tweet.user
      @tweet.delete
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

end
