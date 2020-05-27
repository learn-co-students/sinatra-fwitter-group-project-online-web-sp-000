class TweetsController < ApplicationController

    # create routes ################################################
    get '/tweets/new' do
        # protect so only signed in user can view
        if logged_in?
            erb :"tweets/new_tweet"
        else
            redirect "login"
        end
    end

    post '/tweets' do
        if params[:content] == ""
            redirect '/tweets/new'
        else
            tweet = current_user.tweets.build(params)
            tweet.save
            redirect "/tweets/#{tweet.id}"
        end
    end


    # read routes ################################################
    get '/tweets' do        
        # protect so only signed in user can view
        if logged_in?
            @tweets = Tweet.all
            erb :"tweets/tweets"
        else
            redirect "login"
        end
    end

    get '/tweets/:id' do
        # protect so only signed in user can view
        if logged_in?
            @tweet = Tweet.find(params[:id])
            erb :"tweets/show_tweet"    
        else
            redirect '/login'
        end
    end


    # update routes ################################################
    get '/tweets/:id/edit' do        
        # protect so only signed in user can view
        # protect that only tweet author can actually edit tweet
        if logged_in?
            @tweet = Tweet.find(params[:id])
            if current_user.id == @tweet.user.id
                erb :"tweets/edit_tweet"
            else
                redirect "/tweets"
            end
        else
            redirect "/login"
        end
    end

    patch '/tweets/:id' do
        tweet = Tweet.find(params[:id])
        
        if params[:content] == ""
            redirect "/tweets/#{tweet.id}/edit"
        else
            tweet.update(content: params[:content])
            redirect "/tweets/#{tweet.id}"
        end  
    end


    # delete routes ################################################
    delete '/tweets/:id' do
        # protect that only tweet author can actually edit tweet
        tweet = Tweet.find(params[:id])

        if current_user.id == tweet.user.id
            tweet.destroy
            redirect "/tweets"
        else
            redirect "/tweets"
        end
    end

end
