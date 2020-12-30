# monthly_living_cost: (万円/月)

class RetirementAssetCalc < ApplicationRecord
  attr_accessor :yield_config, :retirement_asset
  # after_find :calculate!

  def load_yield_config(yield_config)
    @yield_config = yield_config
  end

  def self.test_case
    new(monthly_living_cost: 10)
  end

  def calculate!
    self.retirement_asset = (annual_living_cost.to_r / yield_including_tax).to_f
  end

  def annual_living_cost
    monthly_living_cost * 12r
  end

  def yield_including_tax
    yield_config.annual_yield.to_r * 0.01r * tax_rate.to_r * 0.01r
  end
end
