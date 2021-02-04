# monthly_living_cost: (万円/月)

class RetirementAssetCalc < ApplicationRecord
  belongs_to :user

  def retirement_asset
    @retirement_asset ||= calculate
  end

  def calculate
    (annual_living_cost.to_r / yield_including_tax).to_f
  end

  def annual_living_cost
    monthly_living_cost.to_r * 12r
  end

  def yield_including_tax
    annual_yield.to_r * 0.01r * tax_rate.to_r * 0.01r
  end
end
