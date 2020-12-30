# monthly_living_cost: (万円/月)

class RetirementAssetCalc < ApplicationRecord
  before_save :calculate!

  def self.test_case
    new(monthly_living_cost: 10, annual_yield: 5)
  end

  def calculate!
    self.retirement_asset = (annual_living_cost.to_r / yield_including_tax).to_f
  end

  def annual_living_cost
    monthly_living_cost * 12r
  end

  def yield_including_tax
    annual_yield.to_r * 0.01r * tax_rate.to_r * 0.01r
  end
end
