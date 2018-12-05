user1 = User.create(:username => "tuzmusic", :email => "tuzmusic@gmail.com", :password => "kittens")
user2 = User.create(:username => "hollyshulman", :email => "hollyshulman@gmail.com", :password => "kittens")
user3 = User.create(:username => "jordan_morris", :email => "jmorris@maximumfun.org", :password => "kittens")

tweet1 = Tweet.create(:content => "I like programming", user_id: user1.id)
tweet2 = Tweet.create(:content => "Jonathan sucks at getting me gifts", user_id: user2.id)
tweet3 = Tweet.create(:content => "Full chort!", user_id: user3.id)
