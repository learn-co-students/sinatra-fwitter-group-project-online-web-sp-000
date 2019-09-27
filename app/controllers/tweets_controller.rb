class TweetsController < ApplicationController

  get '/tweets' do
    # binding.pry
    if logged_in?
      @tweet = Tweet.all
      @user = current_user
      erb :'tweets/index'
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

  post '/tweets' do
    @tweet = Tweet.new(content: params[:content], user_id: session[:user_id])
    if !params[:content].empty?
      current_user.tweets << @tweet
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      @user = User.find_by(id: @tweet.user_id)
      erb :'/tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
        if logged_in?
            @tweet = Tweet.find_by(id: params[:id])
            @user = User.find_by(id: @tweet.user_id)
            if @user == current_user
                erb :"/tweets/edit"
            else
                redirect '/tweets'
            end
        else
            redirect '/login'
        end
    end

    patch '/tweets/:id' do
      @tweet = Tweet.find_by(id: params[:id])
      if @tweet.user == current_user && !params[:content].empty?
        @tweet.update(content: params[:content])
        redirect to "/tweets/#{@tweet.id}"
      elsif logged_in? && params[:content].empty?
        redirect to "/tweets/#{@tweet.id}/edit"
      else
        redirect '/login'
      end
    end

    delete '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      if @tweet && @user == current_user
        @tweet.delete
      end
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

end
