user = User.create(:username => "skittles123", :email => "skittles@aol.com", :password => "rainbows")
tweet1 = Tweet.create(:content => "tweeting!", :user_id => user.id)
tweet2 = Tweet.create(:content => "tweet tweet tweet", :user_id => user.id)
