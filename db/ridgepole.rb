# :initial_asset, :monthly_purchase, :annual_yield, :monthly_yield

create_table "asset_configs", force: :cascade do |t|
  t.string "initial_asset", null: :false, default: 0
  t.string "monthly_purchase", null: :false, default: 0
  t.string "annual_yield", null: :false, default: 0
  # t.float "monthly_yield", null: :false, default: 0
end
