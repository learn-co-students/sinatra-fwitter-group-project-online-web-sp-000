User.create(:username => "becky567", :email => "starz@aol.com", :password => "kittens")
Tweet.create(:content => "tweeting!", :user_id => user.id)
Tweet.create(:content => "tweet tweet tweet", :user_id => user.id)
