class TweetsController < ApplicationController

    get '/tweets' do
        if !logged_in?
            redirect "/login"
        end

        @user = User.find(session[:user_id])
        erb :"/tweets/index"
    end

    post '/tweets' do
        @user = current_user
        if params[:content] == ""
            redirect '/tweets/new'
        else
            @tweet = Tweet.create(:content => params[:content], :user_id => @user.id)
            redirect '/tweets'
        end
    end

    get '/tweets/new' do
        if !logged_in?
            redirect '/login'
        end
        erb :'/tweets/new'
    end

    get '/tweets/:id' do
        if !logged_in?
            redirect '/login'
        end

        @tweet = Tweet.find_by_id(params[:id])
        erb :'/tweets/show'
    end

    get '/tweets/:id/edit' do
        if logged_in?
            @tweet = Tweet.find_by_id(params[:id])
            if @tweet && @tweet.user == current_user
                erb :'/tweets/edit'
            else
                redirect '/tweets'
            end
        else
            redirect '/login'
        end
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
                    redirect '/tweets'
                end
            end
        else
            redirect '/login'
        end
    end

    delete '/tweets/:id/delete' do
        # binding.pry
        if logged_in?
            @tweet = Tweet.find_by_id(params[:id])
            if @tweet && @tweet.user == current_user
                @tweet.delete
            end
            redirect '/tweets'
        else
            redirect '/login'
        end
    end

end
