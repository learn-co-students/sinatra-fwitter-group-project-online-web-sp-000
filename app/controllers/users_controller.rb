class UsersController < ApplicationController


    get '/' do

        erb :'/users/index'
    end

    get '/signup' do
        if session[:user_id]
            redirect '/tweets'
        else
            erb :'/users/signup'
        end
        end

    post '/signup' do
        if params[:username] != "" && params[:email] != "" && params[:password] != ""
           @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])                   
           @user.save
           session[:user_id] = @user.id
           
           redirect :'/tweets'
    else
        redirect '/users/signup'
    end
    end
        get '/login' do            
            # binding.pry
             if Helpers.is_logged_in?(session)
                redirect '/tweets'
             else
            erb :'/users/login'
             end
        end

        post '/login' do
             @user = User.find_by(username: params[:username])
               
             
             if @user != nil
                session[:user_id] = @user.id 
            # #    binding.pry
            #     redirect '/tweets'
             end
            #  else
            redirect '/tweets'
        end

        get '/logout' do
            session.clear
            redirect '/users/login'
        end

        post '/logout' do
            # binding.pry
            # session[:user_id] = @user.id
            redirect '/tweets'
        end

        get '/users/:id' do
        
            @user = User.find_by(username: params[:id])
            
                @tweets = @user.tweets
        #  binding.pry
            erb :'/users/show'
        end

        
        
end
