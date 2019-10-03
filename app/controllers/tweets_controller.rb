class TweetsController < ApplicationController

  get "/tweets" do 
    if logged_in?
      @user = User.find(session[:user_id])
      @tweets = Tweet.all
      erb :"/tweets/tweets"
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect to '/login'
    end
  end
  
  post "/tweets" do 
    if logged_in? 
      if params[:content] == ""
        redirect "/tweets/new"
      else 
    @tweet = current_user.tweets.build(content: params[:content])
        if @tweet.save 
        redirect "/tweets/#{@tweet.id}"
        else 
        redirect "/tweets/new" 
        end
      end
    else
      redirect "/login" 
    end
  end
  
  get "/tweets/:id" do 
    if logged_in? 
      @tweet = Tweet.find_by_id(params[:id]) 
      erb :"/tweets/show_tweet"
    else 
      redirect "/login" 
    end 
  end 
  
  get "/tweets/:id/edit" do 
    if logged_in? 
      @tweet = Tweet.find(params[:id])
      if @tweet && @tweet.user == current_user 
        erb :"/tweets/edit_tweet" 
      else
      redirect "/tweets"
      end
    else 
      redirect "/login"
    end 
  end 
  
  patch "/tweets/:id" do 
    if logged_in? 
      if params[:content] == ""
      redirect to "/tweets/#{params[:id]}/edit" 
      else
         @tweet = Tweet.find(params[:id])
         if @tweet && @tweet.user == current_user 
         @tweet.update(content: params[:content])
          redirect "/tweets/#{params[:id]}"
        else 
          redirect to "/tweets"
        end 
      end 
    else 
      redirect "/login"
    end
  end
  
  delete "/tweets/:id/delete" do 
    if logged_in?
        @tweet = current_user.tweets.find_by(id: params[:id])
        if @tweet && @tweet.destroy 
        redirect "/tweets"
        else
        redirect "/tweets"
        end
    else 
      redirect "/login" 
    end
  end
  
  

end
