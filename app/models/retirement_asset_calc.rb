# monthly_living_cost: (万円/月)

class RetirementAssetCalc
  attr_accessor :monthly_living_cost, :annual_yield, :tax_rate, :retirement_asset

  def initialize(params)
    @retirement_asset = 0
    @monthly_living_cost = params[:monthly_living_cost].to_f
    @annual_yield = params[:annual_yield].to_f || 0
    @tax_rate = (params[:tax_rate] || 80).to_f
  end

  def self.test_case
    new(monthly_living_cost: 10, annual_yield: 5)
  end

  def calculate!
    self.retirement_asset = (annual_living_cost / yield_including_tax).to_f
  end

  def annual_living_cost
    monthly_living_cost * 12r
  end

  def yield_including_tax
    annual_yield.to_r * 0.01r * tax_rate.to_r * 0.01r
  end
end
