class UsersController < ApplicationController
  
    get '/users/:slug' do
      # if logged_in?
      @user=User.find_by_slug(params[:slug])
      erb :'/users/show'
      # else
        # redirect "/login"
      # end
    end
    
  
    get '/signup' do
        if logged_in? 
          redirect "/tweets"
        else
          erb :'/users/create_user'
        end
    end
      
      post '/signup' do
        # @user = User.new
        # @user.username = params[:username]
        # @user.email = params[:email]
        # @user.password = params[:password]
        # @user.save
        #   redirect("/tweets")
        # # else
        # #     erb :'/users/create_user'
        # # end
            if !params[:username].empty?  && !params[:password].empty? && !params[:email].empty?
              user=User.new(username: params[:username], password: params[:password], email: params[:email] )
              user.save
              session[:user_id] = user.id
              redirect "/tweets"
            else
              redirect "/signup"
            end
      end
      
      get '/login' do
        if !logged_in?
          erb :'/users/login'
        else
            redirect ("/tweets")
        end
      end
      
      post '/login' do
          # login(params[:username], params[:password])
          # redirect ("/tweets")

          user = User.find_by(:username => params[:username])
          if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect to "/tweets"
          else
            redirect to '/signup'
          end
      end
      
      get '/logout' do
        if logged_in?
          session.clear
          redirect "/login"
        else
            redirect ("/login")
        end
      end
    
end
