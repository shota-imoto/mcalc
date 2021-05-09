create_table "asset_configs", force: :cascade do |t|
  t.string "monthly_purchase", null: :false, default: 0
  t.string "annual_yield", null: :false, default: 5
  t.string "user_id", null: :false
end

create_table "retirement_asset_calcs", force: :cascade do |t|
  t.string "monthly_living_budget", null: :false, default: 0
  t.string "ajust_4per_rule", null: false, default: 4
  t.string "user_id", null: :false
end

create_table "asset_records", force: :cascade do |t|
  t.string "amount", null: :false
  t.datetime "date", null: :false
  t.string "user_id", null: :false
  t.timestamps
end

create_table "users", force: :cascade do |t|
  t.string "uuid", null: false
  t.timestamps
end
