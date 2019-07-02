require './config/environment'
require 'sinatra/base'
require 'rack-flash'

class ApplicationController < Sinatra::Base


  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, "password_security"
    enable :sessions
    use Rack::Flash
  end

    # load homepage
    get '/' do
      erb :index
    end

    get "/signup" do
       if Helpers.is_logged_in?(session)
        redirect '/tweets'
      else  
        erb :"users/create_user"
      end 
    end
  
    post "/signup" do
       # params cannot be empty
       params.values.each do |input|
        if input.empty?
          flash[:signup_error] = "Error: All fields must be filled."
           redirect to '/signup'
        end
      end 

      @user = User.create(:username => params[:username], 
              :email => params[:email],
              :password => params[:password])	 
  
      session[:user_id] = @user.id 
      redirect '/tweets'
    end

  get '/tweets' do
      if Helpers.is_logged_in?(session)
        @tweets = Tweet.all
        @user = Helpers.current_user(session)
        erb :'/tweets/tweets'
      else
        redirect '/login'
      end
  end 

  post '/tweets' do
    user = Helpers.current_user(session)

    if params[:content].empty?
      redirect "/tweets/new"
    else
      @user = Helpers.current_user(session)
      @tweet = Tweet.create(content:params[:content], user_id:@user.id)
       redirect "/tweets/#{@tweet.id}"
    end
end

get '/tweets/new' do 
  if Helpers.is_logged_in?(session)
      erb :'/tweets/new'
  else
      redirect '/login'
  end
end 

get '/tweets/:id' do
    if Helpers.is_logged_in?(session)
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show'
    else
      redirect "/login"
    end
end

get '/tweets/:id/edit' do
  if !Helpers.is_logged_in?(session)
    redirect to '/login'
  end

  @tweet = Tweet.find(params[:id])
  if Helpers.current_user(session).id != @tweet.user_id
    redirect to '/tweets'
  end
  erb :"tweets/edit"
end

patch '/tweets/:id' do
    # Content cannot be empty
    if !params[:content].empty?
      @tweet = Tweet.find(params[:id])
      @tweet.content = params[:content]
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{params[:id]}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    if !Helpers.is_logged_in?(session)
      redirect to '/login'
    end
    @tweet = Tweet.find(params[:id])
    
    #Cannot delete other users' tweets
    if Helpers.current_user(session).id != @tweet.user_id
      redirect '/tweets'
    end
    @tweet.delete
    redirect '/tweets'
  end

    get "/login" do 
      if Helpers.is_logged_in?(session)
        redirect '/tweets'
      else
        erb :login
      end 
    end 

    post "/login" do
      user = User.find_by(:username => params[:username])
  
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id 
        redirect '/tweets'
      else
        flash[:loginn_error] = "Error: Cannot authenticate."
        redirect '/login'
      end 
    end

    get '/logout' do
      if Helpers.is_logged_in?(session)
        session.clear
        redirect '/login'
      else
        redirect '/'
      end
    end

    get '/users/:slug' do
      slug = params[:slug]
      @user = User.find_by_slug(slug)
      erb :"users/show"
    end

    # helpers do
    #   def logged_in?
    #     !!session[:user_id]
    #   end

    #   def current_user
    #     User.find(session[:user_id])
    #   end
    # end

end
