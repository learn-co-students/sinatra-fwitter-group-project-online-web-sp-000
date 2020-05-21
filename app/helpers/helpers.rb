class Helpers

  # accept the session hash as an argument
  # This method should use the user_id from the session hash to find the user in the database and return that user
  def self.current_user(session)
    @user = User.find(session[:user_id])
    # @user
  end

  def self.logged_in?(session)
    # @user gives me a user object with key/value pairs
    !!session[:user_id]
  end
end
