u1 = User.create(username: "rick", email: "rick.com", password_digest: SecureRandom.hex)
u2 = User.create(username: "morty", email: "morty.com", password_digest: SecureRandom.hex)

t1 = Tweet.create(content: "something bad", user_id: 1)
t2 = Tweet.create(content: "say it louder for those in the back", user_id: 2)
