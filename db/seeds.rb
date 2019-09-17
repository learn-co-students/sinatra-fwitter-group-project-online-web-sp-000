stuart = User.create(username: "Stuart", email: "stuart@stuart.com", password: "password")
ratchet = User.create(username: "Ratchet", email: "ratchet@ratchet.com", password: "password")

Tweet.create(content: "Ahoy.", user_id: stuart.id)
Tweet.create(content: "Woof!", user_id: ratchet.id)