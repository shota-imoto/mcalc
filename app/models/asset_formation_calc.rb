class AssetFormationCalc
  attr_accessor :asset_sum, :monthly_purchase, :annual_yield, :year_later

  def initialize(params)
    @asset_sum ||= 0
    @monthly_purchase = params[:monthly_purchase].to_i
    @annual_yield = params[:annual_yield].to_i
    @year_later = params[:year_later].to_i
  end

  def calculate
    asset_years_later.asset_sum_round!
  end

  def asset_sum_round!
    self.asset_sum = asset_sum.round
  end

  def asset_years_later
    year_later.times { asset_after_one_year }
    self
  end

  def asset_after_one_year
    12.times { asset_after_one_month }
    asset_sum
  end

  def asset_after_one_month
    self.asset_sum += monthly_purchase
    self.asset_sum *= monthly_yield
  end

  def monthly_yield
    yield_after_a_year = (1 + annual_yield * 0.01)
    yield_after_a_year ** (1.0/12)
  end
end

