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

ActiveRecord::Schema.define(version: 2020_07_16_145801) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attachments", force: :cascade do |t|
    t.string "file"
    t.bigint "ticket_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_id"], name: "index_attachments_on_ticket_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "text"
    t.bigint "ticket_id"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "state_id"
    t.bigint "previous_state_id"
    t.index ["author_id"], name: "index_comments_on_author_id"
    t.index ["previous_state_id"], name: "index_comments_on_previous_state_id"
    t.index ["state_id"], name: "index_comments_on_state_id"
    t.index ["ticket_id"], name: "index_comments_on_ticket_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.bigint "user_id"
    t.string "role"
    t.bigint "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_roles_on_project_id"
    t.index ["user_id"], name: "index_roles_on_user_id"
  end

  create_table "states", force: :cascade do |t|
    t.string "name"
    t.string "color"
    t.boolean "default", default: false
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
  end

  create_table "tags_tickets", id: false, force: :cascade do |t|
    t.bigint "tag_id", null: false
    t.bigint "ticket_id", null: false
    t.index ["tag_id", "ticket_id"], name: "index_tags_tickets_on_tag_id_and_ticket_id"
    t.index ["ticket_id", "tag_id"], name: "index_tags_tickets_on_ticket_id_and_tag_id"
  end

  create_table "ticket_watchers", id: false, force: :cascade do |t|
    t.bigint "ticket_id", null: false
    t.bigint "user_id", null: false
  end

  create_table "tickets", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "author_id"
    t.bigint "state_id"
    t.index ["author_id"], name: "index_tickets_on_author_id"
    t.index ["project_id"], name: "index_tickets_on_project_id"
    t.index ["state_id"], name: "index_tickets_on_state_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.datetime "archived_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "attachments", "tickets"
  add_foreign_key "comments", "states"
  add_foreign_key "comments", "states", column: "previous_state_id"
  add_foreign_key "comments", "tickets"
  add_foreign_key "comments", "users", column: "author_id"
  add_foreign_key "roles", "projects"
  add_foreign_key "roles", "users"
  add_foreign_key "tickets", "projects"
  add_foreign_key "tickets", "states"
  add_foreign_key "tickets", "users", column: "author_id"
end
