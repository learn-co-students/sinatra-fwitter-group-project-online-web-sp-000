class TweetsController < ApplicationController
  
  get '/tweets' do
    if Helpers.is_logged_in?(session)
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
      @tweet.user = @user
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    else
      flash[:message] ="Your tweet must includee content."
      redirect to "/tweets/new"
    end
  end

  get '/tweets/:id/edit' do
    if Helpers.is_logged_in?(session) 
    #  @user= Helpers.current_user(session)
     # if Tweet.find(params[:id]).user_id == @user.id
        @tweet= Tweet.find(params[:id])
        erb :'tweets/edit_tweet'
     # else
      #  redirect to "/tweets"
     # end
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id' do
    if Helpers.is_logged_in?(session)
      #@user = Helpers.current_user(session)
      @tweet= Tweet.find(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    if Helpers.is_logged_in?(session)
     # @user= Helpers.current_user(session)
      @tweet= Tweet.find(params[:id])
      if !params[:content].empty?
        @tweet.content = params[:content]
        @tweet.save
        flash[:message] = "Successfully updated tweet."
        redirect to "/tweets/#{@tweet.id}"
      else
        flash[:message] = "Your tweet cannot be empty."
        redirect to "/tweets/#{@tweet.id}/edit"
      end
    else
      redirect to '/login'
    end
  end      

  delete '/tweets/:id' do
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      @tweet= Tweet.find(params[:id])
      if @tweet.user_id == @user.id
        @tweet.delete
        redirect to "/tweets"
      else
        redirect to "/tweets"
      end
    else
      redirect to "/login"
    end
  end

end
