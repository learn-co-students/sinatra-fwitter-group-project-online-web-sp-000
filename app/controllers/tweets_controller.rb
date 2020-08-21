class TweetsController < ApplicationController

    get '/tweets' do
        if session[:user_id] == nil
            redirect '/login'
         else
           
            @user = User.find(session[:user_id])
            @tweets = Tweet.all
            # binding.pry
            erb :'/tweets/index'
        end
    end

    get '/tweets/new' do
        if Helpers.is_logged_in?(session)
            @user = User.find(session[:user_id])
            @tweet = @user.tweets
        erb :'/tweets/new'
        else
            redirect '/users/login'
        end
    end

    post '/tweets/new' do
        tweet = params[:content]
        if tweet == ""
            redirect '/tweets/new'
        else
            a = Tweet.create(:content => tweet)
            # binding.pry
            id = session[:user_id]
            user = User.find(id)
            user.tweets << a
            user.save
        
            erb :'/tweets/new'
        end
    end

    get '/tweets/:id' do
        #  binding.pry
            if session[:user_id] != params[:id].to_i
                redirect '/users/login'
            else
                @tweet = Tweet.find(params[:id])
            end
    erb :'/tweets/show'
    end

    get '/tweets/:id/edit' do
        if session[:user_id]
        
            @user = User.find(session[:user_id])
            @tweets = @user.tweets
        @id = params[:id].to_i
        @tweet = Tweet.find(@id)
        if @tweet.user_id =! @user.id
            erb :'/tweets/show'
        else
            erb :'/tweets/edit'
        end
        else
        # binding.pry
        # @user.tweets.each do |tweet|
        #     if tweet.user_id = @user.id
        #         @tweet = Tweet.find(params[:id])            
        #         erb :'/tweets/edit'
        #     end
        # end
        redirect '/users/login'
        end
    end

    patch '/tweets/:id' do
        binding.pry
        @tweet = Tweet.find(params[:id])
        @tweet.content = params[:tweets, :content]
        @tweet.save
        redirect '/tweets/show'
    end
end
