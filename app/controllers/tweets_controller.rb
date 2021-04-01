class TweetsController < ApplicationController

    get '/tweets' do
        if Helpers.is_logged_in?(session)
            @user = Helpers.current_user(session)
            erb :'/tweets/tweets'
        else
            redirect to("/login")
        end
    end

    get '/tweets/new' do
        if Helpers.is_logged_in?(session)
            @user = User.find_by(params[:id])
            erb :'/tweets/new'
        else
            redirect to("/login")
        end
    end

    post '/tweets' do
        if Helpers.is_logged_in?(session) && params[:content] != ""
            @user = User.find_by(params[:id])
            @tweet = Tweet.create(:content => params[:content])
            @user.tweets << @tweet
            @user.save
            redirect to("/tweets")
        else
            redirect to("/tweets/new")
        end
        # checks to make sure current user = user who is creating tweet
        # does not allow a tweet to be blank
    end

    get '/tweets/:id' do
        if Helpers.is_logged_in?(session)
            @tweet = Tweet.find_by(params[:id])
            erb :'/tweets/show_tweet'
        else
            redirect to("/login")
        end
        # provides a link to edit page
        # provides a link to delete page, delete page will just be a form with submit button to POST to delete /tweets/:id
        # if not logged in redirect to("/login") 
    end

    get '/tweets/:id/edit' do
        if Helpers.is_logged_in?(session)
            @tweet = Tweet.find_by(params[:id])
            erb :'/tweets/edit_tweet'
        else
            redirect to("/login")
        end
    end

    patch '/tweets/:id' do
        # if user owns tweet :id, lets them edit, else redirects
        # does not let user edit text with blank content
        @user = User.find_by(params[:id])
        @tweet = Tweet.find_by(params[:id])
        if params[:content] != "" && @user.id == @tweet.user_id
            @tweet.update(content: params[:content])
            # @tweet.content = params[:content]
        else
            redirect to("/tweets/#{@tweet.id}/edit")
        end
    end

    delete '/tweets/:id' do
        # if logged in and tweet belongs to user, lets user delete their tweet
        @user = User.find_by(params[:id])
        @tweet = Tweet.find_by(params[:id])
        if Helpers.is_logged_in?(session) && @tweet.user_id == @user.id
            @tweet.delete
        else
            # if not logged in redirect to("/login")
            redirect to("/login")
        end
    end

end
