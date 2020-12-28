# annual_yield: 期待年利
# monthly_purchase: 月々の購入額

class AssetConfig
  attr_accessor :initial_asset, :monthly_purchase, :annual_yield, :monthly_yield


  def initialize(params)
    @initial_asset = params[:initial_asset].to_i
    @monthly_purchase = params[:monthly_purchase].to_i
    @annual_yield = params[:annual_yield].to_i
    @monthly_yield = monthly_yield_calc
  end

  def self.test_case
    self.new(monthly_purchase: 15, annual_yield: 5, initial_asset: 100)
  end

  private

  def monthly_yield_calc
    yield_after_a_year = (1 + annual_yield * 0.01)
    yield_after_a_year ** (1.0/12)
  end
end
