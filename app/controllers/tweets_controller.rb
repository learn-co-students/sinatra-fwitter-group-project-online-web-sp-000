class TweetsController < ApplicationController

    get '/tweets' do
        if logged_in?
            @tweets = Tweet.all
            erb :'tweets/index'
        else
            redirect '/login'
        end
    end

    get '/tweets/new' do
        # if !session[:email]
        if !logged_in?
            redirect '/login'
        else
            erb :'tweets/new'    # new tweet form
        end
    end

    post '/tweets' do
        if logged_in?
            if params[:content] == ""
                redirect "/tweets/new"
            else
                @tweet = current_user.tweets.build(content: params[:content])

                if @tweet.save
                    redirect "/tweets/#{@tweet.id}"
                else
                    redirect "/tweets/new"
                end
            end
        else
            redirect '/login'
        end

        # 1st Attempt:
        # if params[:content] == ""
        #     redirect '/tweets/new'
        # else
        #     @tweet = Tweet.create(:content => params[:content], :user_id => params[:user_id])
        #     tweet[:content] = params[:content]
        #     redirect '/tweets'
        # end 1st
    end

    get '/tweets/:id' do
        if !logged_in?
            redirect '/login'
        else
            @tweet = Tweet.find_by_id(params[:id])
            erb :'tweets/show'
        end
    end

    get '/tweets/:id/edit' do
        if logged_in?
            @tweet = Tweet.find_by_id(params[:id])

            if @tweet && @tweet.user == current_user
                erb :'tweets/edit'
            else
                redirect '/tweets'
            end
        else
            redirect '/login'
        end

        # 1st Attempt:
        # if !logged_in?
        #     redirect '/login'
        # else
        #      # tweet = Post.find(params[:id])
        #     if tweet = current_user.tweets.find(params[:id])
        #         "#{current_user.id} is editing tweet: #{tweet.id}"
        #     else
        #       redirect '/tweets'   # edit tweet form
        #     end
        # end # 1st

    end

    patch '/tweets/:id' do
        if logged_in?
            if params[:content] == ""
                redirect "/tweets/#{params[:id]}/edit"
            else
                @tweet = Tweet.find_by_id(params[:id])

                if @tweet && @tweet.user == current_user

                    if @tweet.update(content: params[:content])
                        redirect "/tweets/#{@tweet.id}"
                    else
                        redirect "/tweets/#{@tweet.id}/edit"
                    end

                else
                    redirect '/tweets'
                end
            end
        else
            redirect '/login'
        end
    end

    delete '/tweets/:id/delete' do
        if !logged_in?
            redirect '/login'
        else
            @tweet = Tweet.find(params[:id])

            if @tweet && @tweet.user == current_user
                @tweet.delete
            end

            redirect '/tweets'
        end
    end

end
