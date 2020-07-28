class TweetsController < ApplicationController

   get '/tweets' do
   
      @tweets = Tweet.all
   
      proc = Proc.new {
         @user = current_user
         erb :'tweets/tweets'
      }

      redirect_if_not_logged_in(proc)
 
   end

   get '/tweets/new' do

      proc = Proc.new {
         erb :'tweets/new'
       }

       redirect_if_not_logged_in(proc)

   end

   post '/tweets' do
    # binding.pry
      @tweet = Tweet.new(params)
      @tweet.user_id = current_user.id
      if @tweet.save
         redirect "/tweets/#{@tweet.id}"
      else
         redirect "/tweets/new"
      end
   end

   get '/tweets/:id/edit' do

      proc = Proc.new {
         @tweet = Tweet.find(params[:id])
         if current_user == @tweet.user
         erb :'tweets/edit_tweet'
         else
            redirect "/tweets/#{@tweet.id}"
         end
      }

      redirect_if_not_logged_in(proc)

   end

   get '/tweets/:id' do
      proc = Proc.new{
         @tweet = Tweet.find(params[:id])
         erb :'tweets/show_tweet'
      }
      redirect_if_not_logged_in(proc)
   end

   patch '/tweets/:id' do
      proc = Proc.new {
         @tweet = Tweet.find(params[:id])
         if current_user == @tweet.user
         @tweet.update(content: params[:content])
            if @tweet.save
               redirect "/tweets/#{@tweet.id}"
            else
               redirect "/tweets/#{@tweet.id}/edit"
            end
         else
            redirect '/login'
         end
      }
      redirect_if_not_logged_in(proc)
   end

   delete '/tweets/:id' do
      @tweet = Tweet.find(params[:id])
      if current_user == @tweet.user
      @tweet.delete
      else
         redirect "/tweets/#{@tweet.id}"
      end
   end

end
#hmmm why wont this submit