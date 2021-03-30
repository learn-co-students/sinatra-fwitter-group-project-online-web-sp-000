rock= User.create(username: "Rock", email: "rock.com", password: "rock")
tweet1= Tweet.new(content: "Hola, como estas?")
tweet2= Tweet.new(content: "Hello, how are you?")
tweet1.user=rock
tweet2.user=rock
tweet1.save
tweet2.save