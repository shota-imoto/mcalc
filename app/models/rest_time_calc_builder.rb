class RestTimeCalcBuilder
  attr_accessor :rest_time_calc

  def initialize(user)
    yield_config = user.yield_config
    asset_config = user.asset_config
    retirement_asset_calc = user.retirement_asset_calc
    if asset_config.present? && yield_config.present? && retirement_asset_calc.present?
      asset_formation_calc = AssetFormationCalc.new(asset_config, yield_config)
      @rest_time_calc = RestTimeCalc.new(asset_formation_calc, retirement_asset_calc, user.id)
    end
  end
end
