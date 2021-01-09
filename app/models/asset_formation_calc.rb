class AssetFormationCalc
  attr_accessor :asset_sum, :asset_config, :yield_config

  def initialize(asset_config, yield_config)
    @asset_sum ||= asset_config.initial_asset
    @asset_config = asset_config
    @yield_config = yield_config
  end

  def self.test_case
    new(AssetConfig.test_case)
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
    self.asset_sum = asset_sum.to_f
    self.asset_sum += asset_config.monthly_purchase.to_i
    self.asset_sum *= yield_config.monthly_yield.to_f
  end
end

