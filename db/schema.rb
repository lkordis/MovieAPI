# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170530171508) do

  create_table "casts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "last_name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "profile_path"
  end

  create_table "comments", primary_key: ["user_id", "review_id"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "text",       limit: 65535
    t.integer  "user_id",                  null: false
    t.integer  "review_id",                null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["review_id"], name: "index_comments_on_review_id", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "credits", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "movie_id"
    t.integer  "cast_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cast_id"], name: "index_credits_on_cast_id", using: :btree
    t.index ["movie_id"], name: "index_credits_on_movie_id", using: :btree
  end

  create_table "friendships", primary_key: ["userId1_id", "userId2_id"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "userId1_id", null: false
    t.integer  "userId2_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["userId1_id"], name: "index_friendships_on_userId1_id", using: :btree
    t.index ["userId2_id"], name: "index_friendships_on_userId2_id", using: :btree
  end

  create_table "movies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "title",       limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "poster_path"
  end

  create_table "ratings", primary_key: ["user_id", "movie_id"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "rating"
    t.integer  "user_id",    null: false
    t.integer  "movie_id",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id"], name: "index_ratings_on_movie_id", using: :btree
    t.index ["user_id"], name: "index_ratings_on_user_id", using: :btree
  end

  create_table "reviews", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "text",       limit: 65535
    t.integer  "user_id"
    t.integer  "movie_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "image_url"
    t.index ["movie_id"], name: "index_reviews_on_movie_id", using: :btree
    t.index ["user_id"], name: "index_reviews_on_user_id", using: :btree
  end

  create_table "seen_movies", primary_key: ["user_id", "movie_id"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id",    null: false
    t.integer  "movie_id",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id"], name: "index_seen_movies_on_movie_id", using: :btree
    t.index ["user_id"], name: "index_seen_movies_on_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "remember_digest"
    t.text     "user_image",      limit: 65535
  end

  create_table "wished_movies", primary_key: ["user_id", "movie_id"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id",    null: false
    t.integer  "movie_id",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id"], name: "index_wished_movies_on_movie_id", using: :btree
    t.index ["user_id"], name: "index_wished_movies_on_user_id", using: :btree
  end

  add_foreign_key "comments", "reviews"
  add_foreign_key "comments", "users"
  add_foreign_key "credits", "casts"
  add_foreign_key "credits", "movies"
  add_foreign_key "friendships", "users", column: "userId1_id"
  add_foreign_key "friendships", "users", column: "userId2_id"
  add_foreign_key "ratings", "movies"
  add_foreign_key "ratings", "users"
  add_foreign_key "reviews", "movies"
  add_foreign_key "reviews", "users"
  add_foreign_key "seen_movies", "movies"
  add_foreign_key "seen_movies", "users"
  add_foreign_key "wished_movies", "movies"
  add_foreign_key "wished_movies", "users"
end
