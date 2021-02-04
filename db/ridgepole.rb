# :initial_asset, :monthly_purchase, :annual_yield, :monthly_yield

create_table "asset_configs", force: :cascade do |t|
  t.string "initial_asset", null: :false, default: 0
  t.string "monthly_purchase", null: :false, default: 0
  t.string "annual_yield", null: :false, default: 5
  t.string "user_id", null: :false
end

create_table "retirement_asset_calcs", force: :cascade do |t|
  t.string "monthly_living_cost", null: :false, default: 0
  t.string "tax_rate", null: :false, default: 80
  t.string "annual_yield", null: :false, default: 5
  t.string "user_id", null: :false
end


create_table "yield_configs", force: :cascade do |t|
  t.string "annual_yield", null: :false, default: 5
  t.string "user_id", null: :false
end

create_table "users", force: :cascade do |t|
  t.string "nickname", null: false

  ## Database authenticatable
  t.string "email", null: false, default: ""
  t.string "encrypted_password", null: false, default: ""

  ## Recoverable
  t.string   "reset_password_token"
  t.datetime "reset_password_sent_at"

  ## Rememberable
  t.datetime "remember_created_at"

  ## Trackable
  # t.integer  :sign_in_count, default: 0, null: false
  # t.datetime :current_sign_in_at
  # t.datetime :last_sign_in_at
  # t.string   :current_sign_in_ip
  # t.string   :last_sign_in_ip

  ## Confirmable
  t.string   "confirmation_token"
  t.datetime "confirmed_at"
  t.datetime "confirmation_sent_at"
  t.string   "unconfirmed_email" # Only if using reconfirmable

  ## Lockable
  t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
  t.string   :unlock_token # Only if unlock strategy is :email or :both
  t.datetime :locked_at

  t.timestamps
end
