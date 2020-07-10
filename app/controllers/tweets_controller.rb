class TweetsController < ApplicationController
    configure do
        set :views, "app/views"
        enable :sessions
        set :session_secret, "password_security"
      end

get "/tweets" do
    if logged_in?
        @user=User.find_by_id(session[:id])
        @tweets=Tweet.all
        erb :'/tweets/index'
    elsif 
        redirect "/login"
    end
end 

get "/tweets/new" do 
    if logged_in?
        erb :'/tweets/new'
    else
        redirect "login"
    end
end

post "/tweets" do 
    if logged_in? && !params["content"].empty?
        tweet=Tweet.create(content: params["content"], user_id: session[:id])
        redirect "/tweets/#{tweet.id}"
    elsif !logged_in?
        redirect "/login"
    elsif params["content"].empty?
        redirect "/tweets/new"
    end
end 

get "/tweets/:id" do
    if logged_in? 
        @tweets=Tweet.find_by_id(params["id"])
        erb :'/tweets/show'
    else
        redirect "/login"
    end
end 

get "/tweets/:id/edit" do
    if logged_in?
        @tweets=Tweet.find_by_id(params["id"]) 
        erb :'/tweets/edit'
    else
        redirect "/login"
    end
end

patch '/tweets/:id/edit' do
    @tweets=Tweet.find_by_id(params["id"])
    if params["content"].empty?
        redirect "/tweets/#{@tweets.id}/edit"
    elsif logged_in? && !params["content"].empty?
        @tweets.update(content: params["content"])
        @tweets.save
        redirect "/tweets/#{@tweets.id}"
    else
        redirect "/login"
    end
end




delete '/tweets/:id' do
    if logged_in?
        @tweets=Tweet.find_by_id(params["id"])
        if current_user.id==@tweets.user_id
            @tweets.delete
            user=User.find_by_id(session[:id])
            redirect "/users/#{user.slug}"
        else
            redirect "/tweets"
        end
    end
end

end