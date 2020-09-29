class UsersController < ApplicationController

     get '/users/:slug' do
          @user = User.find_by_slug(params[:slug])
          erb :'user/show'
        end
      
     
      
        get '/login' do
          if !logged_in?
               erb :'user/login'
          else
               redirect to '/tweets'

          end
        end
      
        post '/login' do
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
            session.destroy
            redirect to '/login'
          else
            redirect to '/'
          end
        end
      end