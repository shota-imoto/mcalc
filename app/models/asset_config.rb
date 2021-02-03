# annual_yield: 期待年利
# monthly_purchase: 月々の購入額

class AssetConfig < ApplicationRecord
  belongs_to :user
  has_one :yield_config, through: :user
  delegate :monthly_yield, to: :YieldConfig

  validates :initial_asset, :monthly_purchase, presence: true

  def self.test_case
    self.new(monthly_purchase: 15, initial_asset: 100)
  end

  def self.find_by_user_or_initialize(params)
    asset_config = find_or_initialize_by(user: params[:user])
    asset_config.assign_attributes(params)
    asset_config
  end
end
