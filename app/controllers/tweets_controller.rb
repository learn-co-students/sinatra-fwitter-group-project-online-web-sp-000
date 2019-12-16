require 'pry'
class TweetsController < ApplicationController

  # we want this in a separate controller but may have inheritence issues

  get '/tweets/new' do
    erb :'tweets/new'
  end

  get '/tweets' do

    if !(Helpers.is_logged_in?(session))
      redirect to '/login'
    end

    @tweets = Tweet.all
    
    erb :'tweets/index'
  end

  post '/tweets' do

      if params[:content].blank? 
        erb :'/tweets/error'
      else
        @tweets = Tweet.create(content: params[:content], user_id: session[:user_id])       
        redirect to '/tweets'
      end

  end  

    # following route does not work successfully
    get '/tweets/:id' do
 
      if Helpers.is_logged_in?(session) 
        @tweet = Tweet.find_by_id(params[:id])
        erb :'tweets/show'
      else
        redirect to '/login'
      end

    end

    # edit a tweet - for specific user
    # if id does not match, redirect to error edit page

    get '/tweets/:id/edit' do # in the form the action is "/tweets/<%=@tweet.id%>"
        @tweet = Tweet.find_by_id(params[:id])
        erb :"/tweets/edit"
    end


    # -------------------------------- patch + delete need to work
    # fix code below, semi works
    patch '/tweets/:id' do
    
      if Helpers.is_logged_in?(session)
        @tweet = Tweet.find_by_id(params[:id])
        @user = User.find_by_id(session[:user_id])
        
        if @tweet.user == @user
          if @tweet.update(content: params[:content])
          redirect to "/tweets/#{@tweet.id}"
          else
            redirect to "tweets/#{@tweet.id}/edit"
          end
        else
          erb :'/tweets/error_delete_edit' 
        end

      else
       # erb :'/tweets/error_delete_edit' # error is user not logged in
       erb :'/users/login'
      end
    end

    # if id does not match, redirect to deelete error page

    delete '/tweets/:id' do
    
      @tweet = Tweet.find_by_id(params[:id])
      @user = User.find_by_id(session[:user_id])
      #session[:user_id] = @user.id

      if @tweet.user_id == @user.id
        @tweet.delete
        redirect to '/tweets'
      else
        erb :'/tweets/error_delete_edit'
      end

    end 

end