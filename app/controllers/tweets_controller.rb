class TweetsController < ApplicationController
    get '/tweets' do
      if logged_in?
        @tweets = Tweet.all
        erb :'tweets/tweets'
      else
        redirect to '/login'
      end
    end
  
    get '/tweets/new' do
      if logged_in?
        erb :'tweets/create_tweet'
      else
        redirect to '/login'
      end
    end
  
    post '/tweets' do
      if logged_in?
        if params[:content] == ""
          redirect to "/tweets/new"
        else
          @tweet = current_user.tweets.build(content: params[:content])
          if @tweet.save
            redirect to "/tweets/#{@tweet.id}"
          else
            redirect to "/tweets/new"
          end
        end
      else
        redirect to '/login'
      end
    end
  
    get '/tweets/:id' do
      if logged_in?
        @tweet = Tweet.find_by_id(params[:id])
        erb :'tweets/show_tweet'
      else
        redirect to '/login'
      end
    end
  
    get '/tweets/:id/edit' do
      if logged_in?
        @tweet = Tweet.find_by_id(params[:id])
        if @tweet && @tweet.user == current_user
          erb :'tweets/edit_tweet'
        else
          redirect to '/tweets'
        end
      else
        redirect to '/login'
      end
    end
  
    patch '/tweets/:id' do
      if logged_in?
        if params[:content] == ""
          redirect to "/tweets/#{params[:id]}/edit"
        else
          @tweet = Tweet.find_by_id(params[:id])
          if @tweet && @tweet.user == current_user
            if @tweet.update(content: params[:content])
              redirect to "/tweets/#{@tweet.id}"
            else
              redirect to "/tweets/#{@tweet.id}/edit"
            end
          else
            redirect to '/tweets'
          end
        end
      else
        redirect to '/login'
      end
    end
  
    delete '/tweets/:id/delete' do
      if logged_in?
        @tweet = Tweet.find_by_id(params[:id])
        if @tweet && @tweet.user == current_user
          @tweet.delete
        end
        redirect to '/tweets'
      else
        redirect to '/login'
      end
    end
  end
# require 'pry'
# class TweetsController < ApplicationController
      
#     get '/tweets' do # index action allowing view to access all recipes thru instance variable @recipes
#         if logged_in?
#             @tweets = current_user.tweets
#             erb :'/tweets/tweets'
#         else
#             erb :'/'
#         end
#       end

#     get '/tweets/new' do # loads form to create new recipe
        
#         if logged_in?
#             erb :'/tweets/create_tweet'
#         else
#             redirect to '/login'
#         end
#     end
    
#     post '/tweets' do
#         if logged_in?
#           if params[:content] == ""
#             redirect to "/tweets/new"
#           else
#             @tweet = current_user.tweets.build(content: params[:content])
#             if @tweet.save
#               redirect to "/tweets/#{@tweet.id}"
#             else
#               redirect to "/tweets/new"
#             end
#           end
#         else
#           redirect to '/login'
#         end
#       end
    
#     get '/tweets/:id' do # show action to display a single recipe. dynamic url allows ID to be called in the view thru params hash
#         if logged_in?
#             @tweet = Tweet.find_by_id(params[:id])
#             erb :'tweets/show_tweet'
#         else
#             redirect to '/login'
#         end
#     end
    
#     get '/tweets/:id/edit' do #load edit form
#         if logged_in?
#             #binding.pry
#             @tweet = current_user.tweets.find_by_id(params[:id])
#             erb :'tweets/edit_tweet'
#         else
#             redirect to '/login'
#         end
#     end
    
#     patch '/tweets/:id' do #edit action. edit form submission. redirect to show page.
#         @tweet = Tweet.find_by_id(params[:id])
#         @tweet.content = params[:content]
#         @tweet.user_id = params[:user_id]
#         @tweet.save
    
#         redirect to "/tweets/#{@tweet.id}"
#         if logged_in?
#             @tweet = current_user.tweets.find_by_id(params[:id])
#             @tweet.content = params[:content]
#             @tweet.save
#             redirect to "/tweets/#{@tweet.id}"
#         else
#             redirect to '/tweets/tweets'
#         end
#     end
    

    
     
    
#     delete '/tweets/:id/delete' do
#         if logged_in?
#           @tweet = Tweet.find_by_id(params[:id])
#           if @tweet && @tweet.user == current_user
#             @tweet.delete
#           end
#           redirect to '/tweets'
#         else
#           redirect to '/login'
#         end
#       end
      

# end
