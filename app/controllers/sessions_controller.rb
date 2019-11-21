class SessionsController < ApplicationController

    get '/logout' do
        if Helpers.is_logged_in?(session)
            session.clear
            redirect to '/login'
            else
                redirect to '/' 
            end
        end

    post '/logout' do
        if Helpers.is_logged_in?(session)
        session.clear
        redirect to '/login'
        else
            redirect to '/login' 
        end
    end


end