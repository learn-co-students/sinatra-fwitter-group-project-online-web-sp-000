class TweetsController < ApplicationController

  get "/tweets/new" do
    if Helpers.is_logged_in?(session)
      erb :"tweets/new"
    else
      redirect '/login'
    end
  end

  get "/tweets/:id" do
    if Helpers.is_logged_in?(session)
      @tweet = Tweet.find_by_id(params[:id])
      erb :"tweets/show"
    else
      redirect '/login'
    end
  end

  get "/tweets/:id/edit" do
    @tweet = Tweet.find_by_id(params[:id])
    if @tweet && (Helpers.current_user(session).id == @tweet.user_id)
      erb :"tweets/edit"
    elsif Helpers.is_logged_in?(session)
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get "/tweets/:id/delete" do
    @tweet = Tweet.find_by_id(params[:tweet_id])
    if @tweet.user_id == Helpers.current_user(session).id
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
    if Helpers.is_logged_in?(session)
      @user = User.find(Helpers.current_user(session).id)
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
