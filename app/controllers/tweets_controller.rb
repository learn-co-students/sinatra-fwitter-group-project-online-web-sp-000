class TweetsController < ApplicationController

    get '/tweets' do 
        if logged_in?
            @tweets = Tweet.all
            erb :'/tweets/index'
        else 
            redirect to "/login"
        end 
    end 

    get '/tweets/new' do 
        
        if !logged_in?
            redirect to "/login"
        else 
            erb :'/tweets/new'
        end 
    end 

    post '/tweets' do 

        if current_user.nil?
            redirect to '/login'
        elsif params[:content].empty?
            redirect to '/tweets/new'
        else
            @tweet = Tweet.create(:content => params[:content])
            @tweet.user_id = current_user.id
            @tweet.save
            
        end
        redirect to '/tweets'
    end 

    get '/tweets/:id' do 
        if logged_in?
            @tweet = Tweet.find_by_id(params[:id])
            erb :'/tweets/show'
        else 
            redirect to "/login"
        end 
    end 

    get '/tweets/:id/edit' do 
        @tweet = Tweet.find_by_id(params[:id])
        if @tweet.user = current_user
            erb :'/tweets/edit'
        else 
            redirect to "/login"
        end 
    end 

    patch '/tweets/:id' do 
        @tweet = Tweet.find_by_id(params[:id])
        @tweet.content = params[:content]
        @tweet.save
        redirect to "/tweets/#{@tweet.id}"
    end 

    delete '/tweets/:id/delete' do 
        if logged_in?
            @tweet = Tweet.find(params[:id])
            if @tweet.user = current_user
                @tweet = Tweet.find_by_id(params[:id])
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
