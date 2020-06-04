class UsersController < ApplicationController

    get "/login" do
        erb :"/users/login"
    end

    get "/signup" do
        if User.logged_in?(session)
            erb :"/tweets/index"
        else
            erb :"/users/signup"
        end
    end

    post "/login" do
        "DEEEEEERP"
    end

    post "/signup" do
        binding.pry
        # if User.logged_in?(session)
        #     redirect "/tweets"
        # else
            if params[:username]
                if params[:email]
                    if params[:password]
                        binding.pry
                        @user = User.new(params)
                        @user.save
                        sessions[:user_id] = @user.id
                        redirect "/tweets"
                    else
                        redirect "/signup"
                    end
                else
                    redirect "/signup"
                end
            else
                redirect "/signup"
            end
        # end
    end

end
