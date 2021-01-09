# monthly_living_cost: (万円/月)

class RetirementAssetCalc < ApplicationRecord
  belongs_to :user
  has_one :yield_config, through: :user

  attr_accessor :retirement_asset
  after_find :calculate!

  def self.test_case
    new(monthly_living_cost: 10)
  end

  def calculate!
    self.retirement_asset = (annual_living_cost.to_r / yield_including_tax).to_f if yield_config
  end

  def annual_living_cost
    monthly_living_cost.to_r * 12r
  end

  def yield_including_tax
    yield_config.annual_yield.to_r * 0.01r * tax_rate.to_r * 0.01r
  end
end
