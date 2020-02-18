require './config/environment'

User.create(:username => "John12", :password => "dog", :email => "address@me.com")
User.create(:username => "SelenaLuvr12", :password => "dog", :email => "address@me.com")
Tweet.create(:content => "An amazing tweet", :user_id => 1)
Tweet.create(:content => "An amazing tweet", :user_id => 1)
Tweet.create(:content => "An amazing tweet", :user_id => 1)
Tweet.create(:content => "Really interesting weather today...", :user_id => 2)
Tweet.create(:content => "Really interesting weather today...", :user_id => 2)
Tweet.create(:content => "Really interesting weather today...", :user_id => 2)
