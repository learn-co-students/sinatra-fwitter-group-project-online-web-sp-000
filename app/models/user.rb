class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

  def slug
    self.username.gsub(' ', '-').downcase if self.username
  end

  def self.find_by_slug(slug)
    self.all.find do |result|
      result.slug == slug
    end
  end


  # # accept the session hash as an argument
  # # This method should use the user_id from the session hash to find the user in the database and return that user
  # def self.current_user(session)
  #
  #   @user = User.find(session[:user_id])
  #
  #   @user
  # end
  #
  # def self.is_logged_in?(session)
  #   # @user gives me a user object with key/value pairs
  #   !!session[:user_id]
  # end

end
