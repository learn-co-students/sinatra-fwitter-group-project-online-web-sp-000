class UsersController < ApplicationController

    get '/signup' do
        # binding.pry
        if session[:current_user] == nil
          erb '/users/signup'
        else
          redirect '/tweets'
        end
      end
    
      post '/signup' do
        # binding.pry
        if params[:username].empty? || params[:email].empty? || params[:password].empty?
          redirect '/signup' 
        else
          @user = User.create(params)
          session[:current_user] = @user.id
          redirect '/tweets'
        end
      end
    
      get '/login' do
        if logged_in?
            redirect '/tweets'
        else
            erb :'/users/login'
        end
      end
    
      post '/login' do
        @user = User.find_by(username: params[:username])
        # binding.pry
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            flash[:message] = "Welcome, #{@user.username}"
            # redirect "/tweets/#{@user.id}"
            # binding.pry
            redirect '/tweets'
          else
            # show an error message
            flash[:message] = "Your credentials were invalid. Try again!"
            # redirecting back to the login page
            # this is where my error message with will display (at the login route)
            redirect '/login'
          end
        end
        get '/logout' do
            # binding.pry
            if logged_in?
                session.clear
                redirect '/login'
            else
                redirect '/login'
            end
          end
        
          post '/logout' do
            binding.pry
            # if logged_in?
            # else
            #     erb :'/users/login'
            # end
          end
        
        get "/users/:slug" do
            @user = User.find(params[:slug])
            @tweets = Tweet.find_by(user_id: @user.id)
            erb :show
        end
    end
