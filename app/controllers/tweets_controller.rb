class TweetsController < ApplicationController

    get '/tweets' do
        if logged_in?
            @tweets = Tweet.all
            erb :'/tweets/index'
        else
            redirect to '/login'
        end
    end

    get '/tweets/new' do
        if logged_in?
            erb :'/tweets/new'
        else
            redirect to '/login'
        end
    end

    get '/tweets/:id' do
        # displays a single tweet
        # if logged out do not let user view tweet - go to 
        if logged_in?
            @tweet = Tweet.find_by(params[:id])
            erb :'/tweets/show'
        else
            redirect :'/login'
        end
    end

    get '/tweets/:id/edit' do
        if logged_in?
            @tweet = Tweet.find_by(params[:id])
            if !@tweet.content.empty? && @tweet.user == current_user
                erb :"/tweets/edit"
            else
                rediredt :'/tweets'
            end           
        else
            redirect :'/login'
        end
    end

    post '/tweets' do
        user = current_user
        if params[:content].empty?
            redirect :'/tweets/new'
        else
            tweet = Tweet.create(content: params[:content], user_id: user.id)
        end
        redirect :'/tweets'        
    end

    patch '/tweets/:id' do

        if logged_in?
           if params[:content].empty?
                redirect :"/tweets/#{params[:id]}/edit"
           else
                @tweet = Tweet.find_by(params[:id])
                if @tweet && @tweet.user == current_user
                    @tweet.update(content: params[:content])

                    redirect :"/tweets/#{@tweet.id}"
                else
                     redirect :"/tweets/#{@tweet.id}/edit"  
                end     
           end 
        else
            redirect :'/login' 
        end
    end

    delete '/tweets/:id' do
        @tweet = Tweet.find_by(params[:id])
        if logged_in? && @tweet.user == current_user
            @tweet.delete
            redirect :'/tweets'          
        else
            redirect :'/login'
        end
    end
end
