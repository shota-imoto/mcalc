# annual_yield: 期待年利
# monthly_purchase: 月々の購入額

class AssetConfig < ApplicationRecord
  attr_accessor :monthly_yield
  after_find :set_monthly_yield

  def set_monthly_yield
    monthly_yield = monthly_yield_calc
  end

  def after_initialize

  end

  def self.test_case
    self.new(monthly_purchase: 15, annual_yield: 5, initial_asset: 100)
  end

  private

  def monthly_yield_calc
    yield_after_a_year = (1 + annual_yield.to_r * 0.01)
    yield_after_a_year ** (1.0/12)
  end
end
