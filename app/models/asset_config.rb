# annual_yield: 期待年利
# monthly_purchase: 月々の購入額

class AssetConfig < ApplicationRecord
  belongs_to :user

  def self.test_case
    self.new(monthly_purchase: 15, initial_asset: 100)
  end
end
