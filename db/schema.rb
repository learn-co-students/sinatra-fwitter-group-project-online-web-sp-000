ActiveRecord::Schema.define(version: 20190320023036) do

  create_table "tweets", force: :cascade do |t|
    t.integer "user_id"
    t.string  "content"
  end

  add_index "tweets", ["user_id"], name: "index_tweets_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
  end

end