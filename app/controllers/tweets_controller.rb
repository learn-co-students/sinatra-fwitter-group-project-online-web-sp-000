class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'/tweets/index'
    else
      redirect '/login'
    end
  end

    get '/tweets/new' do
      if logged_in?
        erb :'/tweets/new'
      else
        redirect '/login'
      end
    end

    post '/tweets/new' do
      #raise params.inspect
    #  binding.pry
      if params[:content] != ""
        @tweet = Tweet.create(:content => params[:content], :user_id => session[:user_id])
        redirect "/tweets/#{@tweet.id}"
      else
        redirect '/tweets/new'
      end
    end

    get '/tweets/:id' do
      if logged_in?
        @tweet = Tweet.find(params[:id])
        erb :'/tweets/show'
      else
        redirect '/login'
      end
    end

    post '/tweets/:id' do
      if params[:content] != ""
        @tweet = Tweet.find(params[:id])
        @tweet.update(:content => params[:content])
      else
        redirect "/tweets/#{params[:id]}/edit"
      end
    end

    post '/tweets/:id/delete'do
      @tweet = Tweet.find(params[:id])
      if session[:user_id] == @tweet.user_id
        @tweet.destroy
      end
      redirect '/tweets'
    end

    get '/tweets/:id/edit' do
      if logged_in?
        @tweet = Tweet.find(params[:id])
        erb :'/tweets/edit'
      else
        redirect '/login'
      end
    end

end
