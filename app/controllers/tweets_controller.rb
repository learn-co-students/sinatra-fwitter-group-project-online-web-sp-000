class TweetsController < ApplicationController

  get '/tweets' do
    if Helpers.is_logged_in?(session)
      @tweets=Tweet.all
      @user=User.find(session[:user_id])
      erb :"/tweets/index"
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if Helpers.is_logged_in?(session)
      erb :'/tweets/new'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    #binding.pry
    unless params[:content].empty?
      @tweet=Tweet.create(:content=>params[:content])
      @user=User.find(session[:user_id])
      @user.tweets<<@tweet
      redirect to '/tweets'
    else
      redirect to '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if Helpers.is_logged_in?(session)
      @tweet=Tweet.find(params[:id])
      erb :'/tweets/show'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    #binding.pry
     @tweet=Tweet.find(params[:id])
     if Helpers.is_logged_in?(session) && Helpers.current_user(session)==@tweet.user
        erb :'/tweets/edit'
     else
        redirect to '/login'
     end
  end

  patch '/tweets/:id' do
    @tweet=Tweet.find(params[:id])
    if @tweet
      unless params[:content].empty?
        @tweet.update(:content=>params[:content])
        redirect to '/tweets'
      else
        redirect to "/tweets/#{@tweet.id}/edit"
      end
    end
  end

  delete '/tweets/:id/delete' do
    @tweet=Tweet.find(params[:id])
    if @tweet && Helpers.current_user(session)==@tweet.user
      @tweet.delete
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end



end
