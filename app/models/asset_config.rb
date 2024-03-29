# annual_yield: 期待年利
# monthly_purchase: 月々の購入額

class AssetConfig < ApplicationRecord
  belongs_to :user
  has_one :yield_config, through: :user

  validates :monthly_purchase, :annual_yield, presence: true, numericality: { greater_than: 0 }

  def monthly_yield
    @monthly_yield ||= monthly_yield_calc
  end

  def asset_after_one_month(sum)
    (sum.to_f + monthly_purchase.to_i) * monthly_yield.to_f
  end

  def self.find_by_user_or_initialize(params)
    asset_config = find_or_initialize_by(user: params[:user])
    asset_config.assign_attributes(params)
    asset_config
  end

  private

  def monthly_yield_calc
    yield_after_a_year = (1 + annual_yield.to_r * 0.01)
    yield_after_a_year ** (1.0/12)
  end
end
