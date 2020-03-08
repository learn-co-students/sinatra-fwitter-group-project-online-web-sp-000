#users
User.create(username: "test1", password: "passoword")
User.create(username: "test2", password: "passoword")
User.create(username: "test2", password: "passoword")

#tweets
Tweet.create(content: "first tweet first user", user_id: 1)
Tweet.create(content: "second tweet second user", user_id: 2)
Tweet.create(content: "third tweet third user", user_id: 3)
Tweet.create(content: "fourth tweet first user", user_id: 1)
