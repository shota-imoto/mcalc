class AssetFormationCalc
  attr_accessor :asset_sum, :asset_config

  def initialize(asset_config)
    @asset_sum ||= asset_config&.initial_asset
    @asset_config = asset_config
  end

  def calculate!(years_later = 0, month_later = 0)
    months = years_later * 12 + month_later
    self.asset_sum = asset_after_months(months)
    self.asset_sum = asset_sum.round
  end

  def asset_after_months(month_later)
    sum = asset_sum.to_f
    month_later.times do |i|
      sum += asset_config.monthly_purchase.to_i # asset_after_one_monthを用いた場合、このメソッドを非破壊的に書くことができなくなるためDRY化していない
      sum *= asset_config.monthly_yield.to_f
    end
    sum
  end

  def asset_after_one_month
    sum = asset_sum.to_f
    sum += asset_config.monthly_purchase.to_i
    sum *= asset_config.monthly_yield.to_f
  end
end

