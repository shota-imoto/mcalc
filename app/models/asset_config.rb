class AssetConfig
  attr_accessor :monthly_purchase, :annual_yield, :monthly_yield


  def initialize(params)
    @monthly_purchase = params[:monthly_purchase].to_i
    @annual_yield = params[:annual_yield].to_i
    @monthly_yield = monthly_yield_calc
  end

  def self.test_case
    self.new(monthly_purchase: 1, annual_yield: 5)
  end

  private

  def monthly_yield_calc
    yield_after_a_year = (1 + annual_yield * 0.01)
    yield_after_a_year ** (1.0/12)
  end
end
