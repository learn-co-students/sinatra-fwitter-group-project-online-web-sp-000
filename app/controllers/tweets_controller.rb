class TweetsController < ApplicationController

  get "/tweets/new" do
    if session[:user_id]
      erb :"tweets/new"
    else
      redirect '/login'
    end
  end

  get "/tweets/:id" do
    if session[:user_id]
      @tweet = Tweet.find_by_id(params[:id])
      erb :"tweets/show"
    else
      redirect '/login'
    end
  end

  get "/tweets/:id/edit" do
    @tweet = Tweet.find_by_id(params[:id])
    if @tweet && (session[:user_id] == @tweet.user_id)
      erb :"tweets/edit"
    elsif session[:user_id]
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get "/tweets/:id/delete" do
    @tweet = Tweet.find_by_id(params[:tweet_id])
    if @tweet.user_id == session[:user_id]
      @tweet.destroy
    end
    redirect '/tweets'
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:tweet_id])
    if params[:content] != ""
      @tweet.content = params[:content]
      @tweet.updated_at = Time.now + Time.zone_offset('EST')
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  get "/tweets" do
    #Need to set variable to session user
    if session[:user_id]
      @user = User.find(session[:user_id])
      @tweets = Tweet.all
      erb :"tweets/index"
    else
      redirect '/login'
    end
  end

  post "/tweets" do
    @tweet = Tweet.new(content: params[:content], user_id: session[:user_id])
    if @tweet.save
      @tweet.created_at = Time.now + Time.zone_offset('EST')
      redirect '/tweets'
    else
      redirect '/tweets/new'
    end
  end

end
