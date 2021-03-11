class TweetsController < ApplicationController
  get "/tweets" do
    if logged_in?
      @tweets = Tweet.all
      erb :'/tweets/index'
    else
      redirect to "/login"
    end
  end

  get "/tweets/new" do
    if !logged_in?
      redirect to "/login"
    else
      erb :'/tweets/new'
    end
  end

  get "/tweets/:id" do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show'
    else
      redirect to "/login"
    end
  end

  get "/tweets/:id/edit" do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet && (@tweet.user == current_user)
        erb :'/tweets/edit'
      else
        redirect to "/tweets"
      end
    else
      redirect to "/login"
    end
  end

  post "/tweets" do
    if current_user.nil?
      redirect to "/login"
    elsif params[:content].empty?
      redirect to "/tweets/new"
    else
      @tweet = Tweet.create(:content => params[:content])
      @tweet.user_id = current_user.id
      @tweet.save
    end
    redirect to "/tweets"
  end

  patch "/tweets/:id" do
    if logged_in?
      if params[:content] == ""
        redirect "/tweets/#{params[:id]}/edit"
      else
        @tweet = Tweet.find_by_id(params[:id])
        if @tweet && (@tweet.user_id == current_user.id)
          @tweet.update(content: params[:content])
          redirect "/tweets/#{@tweet.id}"
        else
          redirect "/tweets"
        end
      end
    else
      redirect "/login"
    end
  end

  delete "/tweets/:id/delete" do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet && (@tweet.user == current_user)
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
