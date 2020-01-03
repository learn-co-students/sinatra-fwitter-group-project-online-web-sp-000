require 'pry'
class Helpers < ActiveRecord::Base


  def self.empty_input?(params)
     (params[:username].empty? ||params[:password].empty?)? true : false
   end

  def self.current_user(session)

     @user = User.find_by_id(session[:user_id])

  end

  def self.is_logged_in?(session)  # session hash 

    !!session[:user_id]

  end

end
