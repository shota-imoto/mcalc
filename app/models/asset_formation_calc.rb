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
      sum = asset_config.asset_after_one_month(sum)
    end
    sum
  end
end

