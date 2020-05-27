joe = User.create(username: "joe", email: "joe@example.com", password: "password")
karen = User.create(username: "jane", email: "jane@example.com", password: "password")
harley = User.create(username: "harley", email: "harley@example.com", password: "password")
zeke = User.create(username: "zeke", email: "zeke@example.com", password: "password")

joe.tweets.build(content: "Joe's 1st tweet").save
joe.tweets.build(content: "Joe's 2nd tweet").save
joe.tweets.build(content: "Joe's 3rd tweet").save
joe.tweets.build(content: "Joe's 4th tweet").save

karen.tweets.build(content: "karen's 1st tweet").save
karen.tweets.build(content: "karen's 2nd tweet").save

harley.tweets.build(content: "harley's 1st tweet").save
harley.tweets.build(content: "harley's 2nd tweet").save
harley.tweets.build(content: "harley's 3rd tweet").save
harley.tweets.build(content: "harley's 4th tweet").save
harley.tweets.build(content: "harley's 5th tweet").save
harley.tweets.build(content: "harley's 6th tweet").save

zeke.tweets.build(content: "zeke's 1st tweet").save
zeke.tweets.build(content: "zeke's 2nd tweet").save
zeke.tweets.build(content: "zeke's 3rd tweet").save
zeke.tweets.build(content: "zeke's 4th tweet").save
zeke.tweets.build(content: "zeke's 5th tweet").save
zeke.tweets.build(content: "zeke's 6th tweet").save
zeke.tweets.build(content: "zeke's 7th tweet").save
zeke.tweets.build(content: "zeke's 8th tweet").save