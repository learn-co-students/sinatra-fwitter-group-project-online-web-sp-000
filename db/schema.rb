# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

<<<<<<< HEAD
ActiveRecord::Schema.define(version: 2) do
=======
ActiveRecord::Schema.define(version: 2020_06_17_144438) do
>>>>>>> 6265492469202805c30fcd2243607474289ef005

  create_table "tweets", force: :cascade do |t|
    t.string "content"
    t.integer "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
<<<<<<< HEAD
    t.string "password_digest"
    t.string "tweet"
=======
    t.string "tweet"
    t.string "password_digest"
>>>>>>> 6265492469202805c30fcd2243607474289ef005
  end

end
