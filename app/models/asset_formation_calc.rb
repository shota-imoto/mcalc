class AssetFormationCalc
  attr_accessor :asset_sum, :asset_config

  def initialize(config)
    @asset_sum ||= 0
    @asset_config = config
  end

  def calculate(years_later)
    asset_after_years(years_later).asset_sum_round!
  end

  def asset_sum_round!
    self.asset_sum = asset_sum.round
  end

  def asset_after_years(year_later)
    year_later.times { asset_after_one_year }
    self
  end

  def asset_after_one_year
    12.times { asset_after_one_month }
    asset_sum
  end

  def asset_after_one_month
    self.asset_sum += asset_config.monthly_purchase
    self.asset_sum *= asset_config.monthly_yield
  end
end

