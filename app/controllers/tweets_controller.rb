class TweetsController < ApplicationController

    get '/tweets/new' do
        if logged_in?
            erb :'tweets/new'
        else
            redirect to '/login'
        end
    end
    
    
    get '/tweets' do
        # binding.pry
        if logged_in?
            @tweets = Tweet.all
            erb :'tweets/tweets'
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

    get '/tweets/:id/edit' do
        if !logged_in? 
            redirect to '/login'
        else
            @tweet = Tweet.find_by(id: params[:id]) 
            if @tweet.user == current_user
                erb :'tweets/edit'
            else
                redirect to '/tweets'
            end
        end

    end

    get '/tweets/:id' do
        if !logged_in?
            redirect to '/login'
        else
            @tweet = Tweet.find_by(id: params[:id])
            erb :'tweets/show'
        end

    end


    patch '/tweets/:id' do
        if params[:content] == ""
            redirect to "/tweets/#{params[:id]}/edit"
        else
            @tweet = Tweet.find_by(id: params[:id])
            @tweet.content = params[:content]
            @tweet.save
            redirect to "/tweets/#{params[:id]}"
        end
    end

    delete '/tweets/:id' do
        # binding.pry
        if !logged_in? 
            redirect to '/login'
        else
            # binding.pry
            if Tweet.find_by(id: params[:id]).user == current_user
                Tweet.destroy(params[:id])
                redirect to '/tweets'
            end
            redirect to "/tweets/#{params[:id]}"
        end
    end









end
