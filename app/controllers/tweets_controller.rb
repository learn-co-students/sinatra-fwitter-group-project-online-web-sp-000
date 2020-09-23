class TweetsController < ApplicationController

    get '/tweets' do 
        # binding.pry
        if Helpers.is_logged_in?(session)#.empty?
            @user = Helpers.current_user(session)#User.find(session[:user_id])
            @tweets = Tweet.all#.filter{|tweet| tweet.user_id == @user.id}
            erb :"tweets/index"
        else 
            redirect to "/login"
        end 
    end 

    get '/tweets/new' do 
        if Helpers.is_logged_in?(session)
            erb :"tweets/new"
        else 
            redirect to "/login"
        end 
    end

    post '/tweets' do 
        @user = Helpers.current_user(session)
        if !params[:content].empty? 
            @tweet = Tweet.create(content: params[:content], user_id: @user.id)
            redirect to "/tweets/#{@tweet.id}"
        else
            redirect to "/tweets/new"
        end
        # redirect to "/tweets/#{@tweet.id}"
    end 

    get '/tweets/:id/edit' do
        if Helpers.is_logged_in?(session)
            @tweet = Tweet.find(params[:id])
            erb :"tweets/edit"
        else 
            redirect to "/login"
        end 
        # erb :"tweets/edit"
    end

    delete '/tweets/:id/delete' do 
        @tweet = Tweet.find(params[:id])
        if Helpers.is_logged_in?(session)
            @user = Helpers.current_user(session)
            @tweet.delete if @tweet.user_id == @user.id
            redirect to "/tweets"
        else 
            redirect to "/login"
        end 
        # erb :"tweets/delete"
    end
    
    get '/tweets/:id' do  
        @tweet = Tweet.find(params[:id])
        # Helpers.is_logged_in?(session) ? erb(:"tweets/show") : redirect to "/login"
        if Helpers.is_logged_in?(session)
            erb :"tweets/show"
        else 
            redirect to "/login"
        end 
    end

    patch '/tweets/:id' do 
        @tweet = Tweet.find(params[:id])
        if params[:content].empty?
            redirect to "/tweets/#{@tweet.id}/edit"
        else 
            @tweet.content = params[:content]
            @tweet.save
            redirect to "/tweets/#{@tweet.id}"
        end 
        # @tweet.content = params[:content]
        # @tweet.save
        # redirect to "/tweets/#{@tweet.id}"
    end

    delete '/tweets/:id' do 
        @tweet = Tweet.find(params[:id])
        redirect to "/tweets/index"
    end

end
