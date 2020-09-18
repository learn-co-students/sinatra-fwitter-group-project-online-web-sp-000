john = User.create(:username => 'john', :email => 'john@gmail.com', :password => 'singing')
gina = User.create(:username => 'gina', :email => 'gina@gmail.com', :password => 'angry')
lane = User.create(:username => 'lane', :email => 'lane@gmail.com', :password => 'pissy')
shawn = User.create(:username => 'shawn', :email => 'shawn@gmail.com', :password => '1234')

Tweet.create(:tweet => "this sucks", :user_id => john.id)
Tweet.create(:tweet => "this sucks", :user_id => gina.id)
Tweet.create(:tweet => "this sucks", :user_id => lane.id)
Tweet.create(:tweet => "this sucks", :user_id => john.id)