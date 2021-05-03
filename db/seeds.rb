user = User.create(username: 'John', email: 'j@email.com', password: 'John')
user.tweets.build(content: 'I am John')
user.tweets.build(content: 'mcgiggles')
user.tweets.build(content: 'I am Groot')
user.tweets.build(content: 'So many bad days')
user.tweets.build(content: '20 mile jog this morning at 1000')
user.save

user = User.create(username: 'Mike', email: 'm@email.com', password: 'Mike')
user.tweets.build(content: '1')
user.tweets.build(content: '3')
user.tweets.build(content: '4')
user.tweets.build(content: '5')
user.tweets.build(content: '6')
user.save