class TweetsController < ApplicationController
    get "/tweets" do

        if User.is_logged_in?(session)
            @tweets = Tweet.all
            @user = User.find_by_id(session[:user_id])
            erb :"/tweets/index"
        else
            redirect "/login"
        end
    end

    get "/tweets/new" do
        if User.is_logged_in?(session)
            @user = User.find_by_id(session[:user_id])
            erb :"/tweets/new"
        else
            redirect "/users/login"
        end
    end

    get "/tweets/:id" do
        if User.is_logged_in?(session)
            @user = User.find_by_id(session[:user_id])
            @tweet = Tweet.find_by_id(params[:id])
            @user_page = User.find_by_id(@tweet.user_id)
            if !@tweet
                @tweet << "There are no tweets by this user"
            end
            erb :"/tweets/show"
        else
            redirect "/login"
        end
    end
    get "/tweets/:id/edit" do
        if User.is_logged_in?(session)
            
            @user  = User.find_by_id(session[:user_id])
            @tweet = Tweet.find_by_id(params[:id])
            @user_page = User.find_by_id(@tweet.user_id)
 
            if @user.id == @user_page.id
                erb :"/tweets/edit"
            
            else
                session.clear
                redirect "/login"
                
            end
        else
            redirect "/login"
        end
    end
    
    post "/tweets" do
        user = User.find_by_id(session[:user_id])
        if params[:content] == ""
            redirect "/tweets/new"
        else
        
        @tweet = Tweet.create(:content => params[:content], :user_id => user.id)
        end
        redirect "/users/#{user.slug}"
        
    end

    post "/delete/:id" do
        user  = User.find_by_id(session[:user_id])
        @tweet = Tweet.find(params[:id])
        user_page = User.find_by_id(@tweet.user_id)

        if user == user_page
            @tweet.destroy
            redirect "/tweets"
        else
            session.clear
            redirect "/login"
        end
    end

    patch "/tweets/:id" do
        user  = User.find_by_id(session[:user_id])
        @tweet = Tweet.find(params[:id])
        user_page = User.find_by_id(@tweet.user_id)

        if user.id == user_page.id
            binding.pry
            if params[:content] == ""
                redirect "/tweets/#{tweet.id}/edit"
            else
             @tweet.update(:content => params[:content])

            redirect "/tweets"
            end
        else
            redirect "/tweets"
        end
    end


end
