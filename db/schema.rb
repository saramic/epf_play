# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130519120514) do

  create_table "ballot_positions", :force => true do |t|
    t.integer "ticket_id"
    t.integer "candidate_id"
    t.integer "position"
  end

  create_table "ballots", :force => true do |t|
    t.integer "state_id"
    t.integer "election_id"
  end

  create_table "candidates", :force => true do |t|
    t.text     "given_name"
    t.text     "surname"
    t.integer  "aec_candidate_id", :null => false
    t.integer  "party_id",         :null => false
    t.integer  "state_id",         :null => false
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "elections", :force => true do |t|
    t.text "name"
    t.date "date"
  end

  create_table "ordinal_preferences", :force => true do |t|
    t.integer  "ballot_position_id"
    t.integer  "ordinal"
    t.integer  "votes"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "parties", :force => true do |t|
    t.text     "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.text     "home_page"
    t.text     "policies"
    t.text     "twitter"
    t.text     "facebook"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "senators", :force => true do |t|
    t.string   "name"
    t.string   "position"
    t.string   "source_url"
    t.string   "source_img_url"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "sources", :force => true do |t|
    t.text     "title"
    t.text     "url"
    t.text     "parent_url"
    t.text     "description"
    t.text     "asset"
    t.text     "hash_identifier"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "sources", ["hash_identifier"], :name => "index_sources_on_hash_identifier"

  create_table "sources_referrers", :id => false, :force => true do |t|
    t.integer "source_id"
    t.integer "referrer_id"
    t.string  "referrer_type"
    t.string  "referrer_field_name"
  end

  add_index "sources_referrers", ["referrer_id", "source_id"], :name => "index_sources_referrers_on_referrer_id_and_source_id"
  add_index "sources_referrers", ["source_id", "referrer_id"], :name => "index_sources_referrers_on_source_id_and_referrer_id"

  create_table "states", :force => true do |t|
    t.text "short_name"
  end

  create_table "tickets", :force => true do |t|
    t.integer "ballot_id"
    t.integer "party_id"
    t.text    "position"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

end
