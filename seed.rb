t=User.create(username:"Test",email:"Test",password:"Test")
d=User.create(username:"Danny",email:"Danny",password:"Danny")
b=User.create(username:"Brooke",email:"Brooke",password:"Brooke")

t1=Tweet.create(content:"Test Tweet!", user_id: t.id)
t2=Tweet.create(content:"Test more stuff for the tester", user_id: t.id)
t3=Tweet.create(content:"Last tweet for the tester!", user_id: t.id)

d1=Tweet.create(content:"Danny test Tweet!", user_id: d.id)
d2=Tweet.create(content:"Danny putting more stuff for the purpose of testings", user_id: d.id)
d3=Tweet.create(content:"Last tweet for Danny, try to Edit!", user_id: d.id)

b1=Tweet.create(content:"Brooke test Tweet!", user_id: b.id)
b2=Tweet.create(content:"Brooke putting more stuff for the purpose of testings", user_id: b.id)
b3=Tweet.create(content:"Last tweet for Brooke, try and delete!", user_id: b.id)