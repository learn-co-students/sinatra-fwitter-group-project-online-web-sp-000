class TweetsController < ApplicationController
  
  get '/tweets' do
    if Helpers.is_logged_in?(session)
      # @user = User.find(session[:user_id])
      #binding.pry
      @tweets= Tweet.all
      @user = Helpers.current_user(session)
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if Helpers.is_logged_in?(session)
      erb :'tweets/new'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    @user= Helpers.current_user(session)
    @tweet = Tweet.new(:content => params[:content])
    if @tweet.save
      #!params[:content].empty?
      #@tweet = Tweet.new(:content => params[:content])
      @tweet.user = @user
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    else
      flash[:message] ="Your tweet must includee content."
      redirect to "/tweets/new"
    end
  end

  get '/tweets/:id/edit' do
    #binding.pry
    if Helpers.is_logged_in?(session) 
      @user= Helpers.current_user(session)
      if Tweet.find(params[:id]).user_id == @user.id
        @tweet= @user.tweets.find(params[:id])
        erb :'tweets/edit_tweet'
      else
        redirect to "/tweets/#{@tweet.id}"
      end
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id' do
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      @tweet= @user.tweets.find(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    if Helpers.is_logged_in?(session)
      @user= Helpers.current_user(session)
      @tweet= @user.tweets.find(params[:id])
      if !params[:content].empty?
        @tweet.content = params[:content]
        @tweet.save
        redirect to "/tweets/#{@tweet.id}"
      else
        redirect to "/tweets/#{@tweet.id}/edit"
      end
    else
      redirect to '/login'
    end
  end      

  delete '/tweets/:id' do
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      @tweet= @user.tweets.find(params[:id])
      @tweet.destroy
      redirect to "/tweets"
    else
      redirect to "/login"
    end
  end

end
