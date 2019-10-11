users_list = {
    "Bilbo" => {
      :username => "bilbo",
      :email => "bilbo@gmail.com"
    },
    "Frodo" => {
      :username => "frodo",
      :email => "frodo@gmail.com"
    }
  }

users_list.each do |name, info_hash|
  u = User.new
  info_hash.each do |attribute, value|
      u[attribute] = value
  end
  u.save
end

tweets = {
    "bilbo" => "I found it",
    "frodo" => "it's mine now"
  }

tweets.each do |name, tweet_content|
  t = Tweet.new
  t.content = tweet_content
  t.user = User.find_by(username: name)
  t.save
end