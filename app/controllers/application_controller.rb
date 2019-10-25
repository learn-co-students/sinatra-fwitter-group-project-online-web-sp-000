require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

   get '/' do
     erb :index
   end

   get '/login' do

     if Helpers.logged_in?(session)
       redirect to '/tweets'
     else
     erb :"/users/login"
     end
   end

   get '/signup' do
     if Helpers.logged_in?(session)
       redirect to '/tweets'
     else
     erb :'/users/create_users'
     end
   end

   post '/signup' do
     @username = params[:username]
     @password = params[:password]
     @email = params[:email]

     if !@username.empty? && !@password.empty? && !@email.empty?
       @user = User.create(username: :username, password: :password, email: :email)
       session[:user_id] = @user.id
       redirect '/tweets'
     else
       redirect '/signup'
     end

   end
   post '/login' do
     @user = User.find_by(:username => params[:username])
       if @user && @user.authenticate(params[:password])
         session[:user_id] = @user.id
         redirect '/tweets'
       else
         redirect '/login'
       end
   end

   get '/tweets' do
    if !Helpers.logged_in?(session)
      redirect to '/login'
    end
    @tweets = Tweet.all
    @user = Helpers.current_user(session)
    erb :"/tweets/index"
  end

  get '/tweets/new' do
    if !Helpers.logged_in?(session)
      redirect '/login'
    else
      erb :'/tweets/new'
    end
  end

  post '/tweets' do
    user = Helpers.current_user(session)
    @content = params[:content]
    if @content.empty?
      redirect '/tweets/new'
    else
      @tweet = Tweet.create(:content => params["content"], :user_id => user.id)
      redirect '/tweets'
    end
  end

  get '/tweets/:id' do
    if !Helpers.logged_in?(session)
      redirect to '/login'
    end
    @tweet = Tweet.find(params[:id])
    erb :"tweets/show"
  end

  get '/tweets/:id/edit' do
    if !Helpers.logged_in?(session)
      redirect to '/login'
    end
    @tweet = Tweet.find(params[:id])
    if Helpers.current_user(session).id != @tweet.user_id
      redirect to '/tweets'
    end
    erb :"tweets/edit"
  end

  patch '/tweets/:id' do
      tweet = Tweet.find(params[:id])

      if params[:content].empty?
        redirect to "/tweets/#{params[:id]}/edit"
      end
      tweet.update(:content => params["content"])

      tweet.save

      redirect to "/tweets/#{tweet.id}"
    end

  # patch '/tweets/:id' do
  #   @tweet = Tweet.find(params[:id])
  #   if !params[:content].empty?
  #   @tweet.update(:content => params["content"])
  #   @tweet.save
  #   redirect '/tweets/#{@tweet.id}'
  #  else
  #    redirect '/tweets/#{@tweet.id}/edit'
  #  end
  # end

  post '/tweets/:id/delete' do
    if !Helpers.logged_in?(session)
      redirect to '/login'
    end
    @tweet = Tweet.find(params[:id])
    if Helpers.current_user(session).id != @tweet.user_id
      redirect to '/tweets'
    end
    @tweet.delete
    redirect to '/tweets'
  end

  get '/users/:slug' do
      slug = params[:slug]
      @user = User.find_by_slug(slug)
      erb :"users/show"
    end

   get '/logout' do
     if Helpers.logged_in?(session)
       session.clear
       redirect "/login"
     else
       redirect '/'
     end
   end




end
