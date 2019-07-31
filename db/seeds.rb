@eli = User.create(username: "Eli", email: "eli@fake.com", password: "Pass")
@aubrey = User.create(username: "Aubrey", email: "aubrey@fake.net", password: "Lando")
@tweet1 = Tweet.create(content: "Hello Fwitter!!", user: @eli)
@tweet2 = Tweet.create(content: "I love my dog!!", user: @aubrey)
