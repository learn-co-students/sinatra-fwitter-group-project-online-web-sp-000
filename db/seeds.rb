#Create Users

bobafett = User.create(username: "BobaFett", email: "bobafett@theguild.com", password: "password")
vader = User.create(username: "DarthVader", email: "vader@evilempire.com", password: "password")

#Create Tweets

Tweet.create(content: "He's no good to me dead.", user_id: bobafett.id)
Tweet.create(content: "I am your father?", user_id: vader.id)
Tweet.create(content: "I've altered the deal. Pray I don't alter it any further.", user_id: vader.id)