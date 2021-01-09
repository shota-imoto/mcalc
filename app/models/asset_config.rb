# annual_yield: 期待年利
# monthly_purchase: 月々の購入額

class AssetConfig < ApplicationRecord
  belongs_to :user
  has_one :yield_config, through: :user
  delegate :monthly_yield, to: :YieldConfig

  def self.test_case
    self.new(monthly_purchase: 15, initial_asset: 100)
  end
end
