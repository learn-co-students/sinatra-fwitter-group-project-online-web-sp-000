class TweetsController < ApplicationController

# make a login helper method, it converts the value of current user to a boolean so its true or false 

  get '/tweets' do
    # binding.pry
    if current_user
        # binding.pry
      @tweets = Tweet.all
      erb :"tweets/index"
    else 
      redirect "/login"
    end
  end 

  get '/tweets/new' do 
    # binding.pry
    if logged_in?
      # binding.pry
      erb :"tweets/new"
    else 
      # binding.pry
      redirect to "/login"
    end 

    # erb :"tweets/new"
  end 

  post '/tweets' do 
    # binding.pry
    if !params[:content].empty? 
      @tweet = Tweet.new(content: params[:content], user_id: session[:user_id]) 
      # binding.pry
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    else 
      redirect "/tweets/new"
    end 

  end 

  get '/tweets/:id' do 
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      erb :"tweets/show"
    else 
      redirect "/login"
    end 
  end 

  delete '/tweets/:id/delete' do 
    # binding.pry
    if logged_in?
        # binding.pry
      @tweet = Tweet.find_by(id: params[:id])
      if @tweet.user_id == current_user.id
        @tweet.destroy
      else 
         redirect to '/tweets'
      end 
      redirect to '/tweets'
    else 
        # binding.pry
      redirect to "/login"
    end 
  end 

  get '/tweets/:id/edit' do 
    if logged_in?
      # binding.pry
      @tweet = Tweet.find_by(user_id: params[:id])
      erb :'tweets/edit'
    else 
      redirect "/login"
    end
  end 

  patch '/tweets/:id' do 
    # binding.pry
    if logged_in?
      @tweet = Tweet.find_by(user_id: params[:id])
        if  !params[:content].empty? || params[:content] != ""
            @tweet.content = params[:content]
            @tweet.save
            redirect "/tweets/#{@tweet.id}"
        end 
       redirect to "/tweets/#{@tweet.id}/edit"
    else 
     redirect "/login"
  end
  end 


end