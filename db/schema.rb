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

ActiveRecord::Schema.define(version: 20180308064834) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.text "content"
    t.bigint "question_id"
    t.bigint "message_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "keyword", default: [], array: true
    t.boolean "has_next_msg", default: false
    t.index ["message_id"], name: "index_answers_on_message_id"
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "api_keys", force: :cascade do |t|
    t.string "access_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "site_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.datetime "deleted_at"
    t.string "eval_A_name"
    t.string "eval_A_type"
    t.string "eval_A_value"
    t.string "eval_B_name"
    t.string "eval_B_type"
    t.string "eval_B_value"
    t.string "eval_C_name"
    t.string "eval_C_type"
    t.string "eval_C_value"
    t.string "eval_D_name"
    t.string "eval_D_type"
    t.string "eval_D_value"
    t.string "eval_E_name"
    t.string "eval_E_type"
    t.string "eval_E_value"
    t.integer "user_id"
    t.boolean "activity", default: true
    t.integer "owner_id"
    t.text "tags"
    t.integer "site_id"
    t.index ["deleted_at"], name: "index_categories_on_deleted_at"
  end

  create_table "category_logs", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.string "eval_A_name"
    t.string "eval_A_type"
    t.string "eval_A_value"
    t.string "eval_B_name"
    t.string "eval_B_type"
    t.string "eval_B_value"
    t.string "eval_C_name"
    t.string "eval_C_type"
    t.string "eval_C_value"
    t.string "eval_D_name"
    t.string "eval_D_type"
    t.string "eval_D_value"
    t.string "eval_E_name"
    t.string "eval_E_type"
    t.string "eval_E_value"
    t.datetime "deleted_at"
    t.bigint "user_id"
    t.boolean "activity"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "site_id"
    t.text "tags"
    t.index ["category_id"], name: "index_category_logs_on_category_id"
    t.index ["user_id"], name: "index_category_logs_on_user_id"
  end

  create_table "chatbot_emotion_photos", force: :cascade do |t|
    t.integer "chatbot_id"
    t.integer "chatbot_emotion_id"
    t.string "name"
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chatbot_emotions", force: :cascade do |t|
    t.string "emotion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chatbot_logs", force: :cascade do |t|
    t.bigint "session_statistic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_type"
    t.integer "message_array", default: [], array: true
    t.string "message_type"
    t.index ["session_statistic_id"], name: "index_chatbot_logs_on_session_statistic_id"
  end

  create_table "chatbots", force: :cascade do |t|
    t.string "name"
    t.boolean "activity", default: true
    t.text "profile"
    t.string "rarity"
    t.string "tag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "created_user_id"
    t.integer "site_id"
  end

  create_table "click_statistics", force: :cascade do |t|
    t.string "clicked_type"
    t.bigint "clicked_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "session_statistic_id"
    t.integer "site_id"
    t.index ["clicked_type", "clicked_id"], name: "index_click_statistics_on_clicked_type_and_clicked_id"
  end

  create_table "conversation_statuses", force: :cascade do |t|
    t.bigint "session_statistic_id"
    t.integer "status", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "chatting", default: [], array: true
    t.boolean "story_job", default: false
    t.integer "click_closing", default: 0
    t.integer "site_id"
    t.index ["session_statistic_id"], name: "index_conversation_statuses_on_session_statistic_id"
  end

  create_table "conversion_tags", force: :cascade do |t|
    t.string "fingerprint"
    t.text "referrer"
    t.bigint "session_statistic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "current_url"
    t.string "api_key"
    t.integer "site_id"
    t.index ["session_statistic_id"], name: "index_conversion_tags_on_session_statistic_id"
  end

  create_table "customer_informations", force: :cascade do |t|
    t.integer "session_statistic_id"
    t.string "zipcode"
    t.string "prefecture"
    t.string "municipality"
    t.string "street"
    t.string "building"
    t.string "name"
    t.string "email"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cv_transactions", force: :cascade do |t|
    t.bigint "product_id"
    t.string "cv_transaction_key"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "session_statistic_id"
    t.integer "site_id"
    t.index ["product_id"], name: "index_cv_transactions_on_product_id"
  end

  create_table "dislike_statistics", force: :cascade do |t|
    t.string "dislike_type"
    t.bigint "dislike_id"
    t.text "dislike_reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "session_statistic_id"
    t.integer "site_id"
    t.index ["dislike_type", "dislike_id"], name: "index_dislike_statistics_on_dislike_type_and_dislike_id"
  end

  create_table "form_headers", force: :cascade do |t|
    t.string "header_key"
    t.string "header_value"
    t.bigint "form_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["form_id"], name: "index_form_headers_on_form_id"
  end

  create_table "form_messages", force: :cascade do |t|
    t.bigint "form_id"
    t.bigint "message_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["form_id"], name: "index_form_messages_on_form_id"
    t.index ["message_id"], name: "index_form_messages_on_message_id"
  end

  create_table "forms", force: :cascade do |t|
    t.bigint "site_id"
    t.text "form_name"
    t.text "api_url"
    t.text "form_body"
    t.text "generated_body"
    t.boolean "activity", default: true
    t.boolean "auto_generate", default: true
    t.integer "created_user_id"
    t.integer "updated_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "form_action", default: "POST"
    t.index ["site_id"], name: "index_forms_on_site_id"
  end

  create_table "keywords", force: :cascade do |t|
    t.string "name"
    t.boolean "activity", default: true
    t.float "cpc"
    t.bigint "master_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "created_user_id"
    t.integer "updated_user_id"
    t.integer "site_id"
    t.index ["master_category_id"], name: "index_keywords_on_master_category_id"
  end

  create_table "line_messages", force: :cascade do |t|
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.text "content"
    t.text "button_wording"
    t.text "language_note"
    t.integer "updated_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "chatbot_id"
    t.string "line_address"
    t.boolean "activity", default: true
    t.index ["chatbot_id"], name: "index_line_messages_on_chatbot_id", unique: true
  end

  create_table "link_cards", force: :cascade do |t|
    t.string "url"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.string "image_url"
    t.integer "message_id"
    t.string "content_type"
    t.bigint "content_id"
    t.index ["content_type", "content_id"], name: "index_link_cards_on_content_type_and_content_id"
  end

  create_table "master_categories", force: :cascade do |t|
    t.string "name"
    t.boolean "activity", default: true
    t.integer "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "created_user_id"
    t.integer "updated_user_id"
    t.integer "site_id"
  end

  create_table "message_contents", force: :cascade do |t|
    t.integer "row_order", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "content_id"
    t.string "content_type"
    t.integer "message_id"
  end

  create_table "message_statistics", force: :cascade do |t|
    t.integer "click_closing", default: 0
    t.bigint "message_id"
    t.bigint "conversation_status_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "site_id"
    t.index ["conversation_status_id"], name: "index_message_statistics_on_conversation_status_id"
    t.index ["message_id"], name: "index_message_statistics_on_message_id"
  end

  create_table "messages", force: :cascade do |t|
    t.boolean "activity"
    t.integer "priority"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "keyword_id"
    t.integer "tag_id"
    t.boolean "is_draft", default: false
    t.string "message_type"
    t.datetime "deleted_at"
    t.integer "created_user_id"
    t.integer "updated_user_id"
    t.float "weight"
    t.integer "site_id"
    t.integer "chatbot_id"
    t.index ["deleted_at"], name: "index_messages_on_deleted_at"
  end

  create_table "partner_sites", force: :cascade do |t|
    t.string "site_url"
    t.integer "display_number", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "site_id"
  end

  create_table "photo_groups", force: :cascade do |t|
    t.integer "photo_group_id"
    t.integer "message_id"
    t.string "content_type"
    t.bigint "content_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["content_type", "content_id"], name: "index_photo_groups_on_content_type_and_content_id"
  end

  create_table "photos", force: :cascade do |t|
    t.integer "message_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "photo_file_name"
    t.string "photo_content_type"
    t.integer "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer "photo_group_id"
  end

  create_table "product_logs", force: :cascade do |t|
    t.string "name"
    t.bigint "category_id"
    t.string "product_url"
    t.string "slug"
    t.string "catch_copy"
    t.float "price_per_time"
    t.float "price"
    t.string "campaign"
    t.string "order_site"
    t.string "manufacturer"
    t.string "specificity"
    t.text "content"
    t.string "price_details"
    t.text "useful_ingredients"
    t.text "components"
    t.string "usage_target"
    t.text "image_1_url"
    t.text "image_2_url"
    t.text "image_3_url"
    t.text "image_4_url"
    t.text "image_5_url"
    t.integer "evaluation_score_a"
    t.integer "evaluation_score_b"
    t.integer "evaluation_score_c"
    t.integer "evaluation_score_d"
    t.integer "evaluation_score_e"
    t.text "evaluation_comment_a"
    t.text "evaluation_comment_b"
    t.text "evaluation_comment_c"
    t.text "evaluation_comment_d"
    t.text "evaluation_comment_e"
    t.text "evaluation_category_a"
    t.text "evaluation_category_b"
    t.text "evaluation_category_c"
    t.text "evaluation_category_d"
    t.text "evaluation_category_e"
    t.text "summary"
    t.text "money_back"
    t.string "status_deliver_time"
    t.string "credit_settlement"
    t.boolean "postpay"
    t.boolean "cod"
    t.boolean "bank_transfer"
    t.boolean "store_transfer"
    t.date "delivery_date"
    t.datetime "deleted_at"
    t.string "csv_file_name"
    t.bigint "user_id"
    t.bigint "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "site_id"
    t.index ["category_id"], name: "index_product_logs_on_category_id"
    t.index ["product_id"], name: "index_product_logs_on_product_id"
    t.index ["user_id"], name: "index_product_logs_on_user_id"
  end

  create_table "product_messages", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "message_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message_id"], name: "index_product_messages_on_message_id"
    t.index ["product_id"], name: "index_product_messages_on_product_id"
  end

  create_table "product_reports", force: :cascade do |t|
    t.integer "product_id"
    t.string "display_url"
    t.string "api_key"
    t.integer "site_id"
    t.float "sales"
    t.float "sales_per_display"
    t.float "sales_per_click"
    t.float "display_number"
    t.float "click_number"
    t.float "cv_number"
    t.float "click_rate"
    t.string "type_report"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "cv_rate"
  end

  create_table "product_statistics", force: :cascade do |t|
    t.integer "site_id"
    t.integer "product_id"
    t.integer "statistic_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "display_url"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "product_url"
    t.string "slug"
    t.string "catch_copy"
    t.float "price_per_time"
    t.float "price"
    t.string "campaign"
    t.string "order_site"
    t.string "manufacturer"
    t.string "specificity"
    t.text "content"
    t.string "price_details"
    t.text "useful_ingredients"
    t.text "components"
    t.string "usage_target"
    t.text "image_1_url"
    t.text "image_2_url"
    t.text "image_3_url"
    t.text "image_4_url"
    t.text "image_5_url"
    t.integer "evaluation_score_a"
    t.integer "evaluation_score_b"
    t.integer "evaluation_score_c"
    t.integer "evaluation_score_d"
    t.integer "evaluation_score_e"
    t.text "evaluation_comment_a"
    t.text "evaluation_comment_b"
    t.text "evaluation_comment_c"
    t.text "evaluation_comment_d"
    t.text "evaluation_comment_e"
    t.text "evaluation_category_a"
    t.text "evaluation_category_b"
    t.text "evaluation_category_c"
    t.text "evaluation_category_d"
    t.text "evaluation_category_e"
    t.string "status_deliver_time"
    t.string "credit_settlement"
    t.boolean "postpay"
    t.boolean "cod"
    t.boolean "bank_transfer"
    t.boolean "store_transfer"
    t.date "delivery_date"
    t.datetime "deleted_at"
    t.integer "user_id"
    t.boolean "activity", default: true
    t.string "money_back"
    t.string "summary"
    t.integer "owner_id"
    t.string "csv_file_name"
    t.text "tags"
    t.text "description"
    t.bigint "site_id"
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["deleted_at"], name: "index_products_on_deleted_at"
    t.index ["site_id"], name: "index_products_on_site_id"
  end

  create_table "questions", force: :cascade do |t|
    t.text "content"
    t.bigint "chatbot_emotion_id"
    t.bigint "message_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chatbot_emotion_id"], name: "index_questions_on_chatbot_emotion_id"
    t.index ["message_id"], name: "index_questions_on_message_id"
  end

  create_table "quotes", force: :cascade do |t|
    t.text "content"
    t.string "quote_url"
    t.string "quote_source"
    t.string "referral_comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "message_id"
    t.index ["message_id"], name: "index_quotes_on_message_id"
  end

  create_table "relative_keywords", force: :cascade do |t|
    t.integer "keyword_id"
    t.integer "message_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "responses", force: :cascade do |t|
    t.string "response_url"
    t.string "response_key"
    t.string "response_type", default: "success"
    t.string "message_type"
    t.string "title"
    t.string "description"
    t.string "text_message"
    t.string "image_url"
    t.boolean "done"
    t.boolean "activity", default: true
    t.bigint "form_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position"
    t.index ["form_id"], name: "index_responses_on_form_id"
  end

  create_table "roles", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.integer "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
  end

  create_table "session_statistics", force: :cascade do |t|
    t.string "session_key"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "location"
    t.string "ip_address"
    t.string "platform"
    t.string "browser"
    t.integer "site_id"
  end

  create_table "settings", force: :cascade do |t|
    t.string "meta_key"
    t.string "meta_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sites", force: :cascade do |t|
    t.string "name"
    t.string "site_url"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "aibot_address"
    t.index ["user_id"], name: "index_sites_on_user_id"
  end

  create_table "stories", force: :cascade do |t|
    t.integer "start_keyword_id"
    t.integer "end_keyword_id"
    t.integer "display_number"
    t.integer "messages_list", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "average_staying_time", default: 0.0
    t.integer "click_closing", default: 0
    t.integer "site_id"
  end

  create_table "tag_messages", force: :cascade do |t|
    t.integer "tag_id"
    t.integer "message_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.boolean "activity", default: true
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "created_user_id"
    t.integer "updated_user_id"
    t.integer "site_id"
  end

  create_table "text_messages", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "chatbot_emotion_id"
    t.bigint "message_id"
    t.index ["chatbot_emotion_id"], name: "index_text_messages_on_chatbot_emotion_id"
    t.index ["message_id"], name: "index_text_messages_on_message_id"
  end

  create_table "tutorial_steps", force: :cascade do |t|
    t.string "name"
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.string "title"
    t.text "content"
    t.string "button_wording"
    t.integer "tutorial_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tutorials", force: :cascade do |t|
    t.integer "updated_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "chatbot_id"
    t.boolean "activity", default: true
    t.index ["chatbot_id"], name: "index_tutorials_on_chatbot_id", unique: true
  end

  create_table "user_accesses", force: :cascade do |t|
    t.string "ip_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "site_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.boolean "activity", default: true
    t.integer "updated_user_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
  end

  create_table "users_sites", force: :cascade do |t|
    t.integer "user_id"
    t.integer "site_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "video_groups", force: :cascade do |t|
    t.integer "video_group_id"
    t.integer "message_id"
    t.string "content_type"
    t.bigint "content_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["content_type", "content_id"], name: "index_video_groups_on_content_type_and_content_id"
  end

  create_table "videos", force: :cascade do |t|
    t.integer "message_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "video_meta"
    t.string "video_file_name"
    t.string "video_content_type"
    t.integer "video_file_size"
    t.datetime "video_updated_at"
    t.string "video_type"
    t.string "youtube_url"
    t.integer "video_group_id"
  end

  add_foreign_key "conversation_statuses", "session_statistics"
  add_foreign_key "conversion_tags", "session_statistics"
  add_foreign_key "form_headers", "forms"
  add_foreign_key "form_messages", "forms"
  add_foreign_key "form_messages", "messages"
  add_foreign_key "message_statistics", "conversation_statuses"
  add_foreign_key "message_statistics", "messages"
  add_foreign_key "product_messages", "messages"
  add_foreign_key "product_messages", "products"
  add_foreign_key "products", "sites"
  add_foreign_key "quotes", "messages"
  add_foreign_key "responses", "forms"
  add_foreign_key "text_messages", "chatbot_emotions"
  add_foreign_key "text_messages", "messages"
end
