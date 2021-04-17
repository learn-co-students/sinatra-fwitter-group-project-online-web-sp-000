class TweetsController < ApplicationController
    
    get "/tweets" do 
        
        if Helpers.is_logged_in?(session)
            
            erb :'/tweets/tweets'

        else

            redirect "/login"

        end
    end

    get "/tweets/new" do
        if Helpers.is_logged_in?(session)

            erb :'tweets/new'
        else
            redirect "/login"
        end

    
    end

    post "/tweets" do

        if !params[:content].empty?

        @user = User.find_by(id: session[:user_id])
        @tweet = Tweet.new(content: params[:content])
        @tweet.user = @user
        @tweet.save
                
        erb :"/tweets/tweets"

        else
            @error = "You need to add content to create a tweet!"

            redirect "/tweets/new"
        end

    end

     get "/tweets/:id" do

        if Helpers.is_logged_in?(session)

         @tweet = Tweet.find(params[:id])

         erb :'/tweets/show_tweet'

        else
         redirect "/login"  
        end 
     end

     

     get "/tweets/:id/edit" do

        if Helpers.is_logged_in?(session)

            @tweet = Tweet.find(session[:user_id])
   
            erb :'/tweets/edit_tweet'
        else
            redirect "/login"
        end

     end

     patch "/tweets/:id" do

        @tweet = Tweet.find_by(params[:id])

        if !params["tweet"]["content"].empty?
    
        @tweet.update(params["tweet"])

        redirect "/tweets/#{@tweet.id}"

        else
            redirect "/tweets/#{@tweet.id}/edit"
        end
     end

     delete "/tweets/:id" do
        if Helpers.is_logged_in?(session)

        @tweet = Tweet.find_by(params[:id])
        
        @tweet.destroy

        else
            redirect "/tweets/#{@tweet.id}"
        end

     end




end
