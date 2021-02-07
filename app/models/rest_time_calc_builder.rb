class RestTimeCalcBuilder
  attr_accessor :rest_time_calc

  def initialize(user)
    asset_config = user.asset_config
    retirement_asset_calc = user.retirement_asset_calc
    @rest_time_calc = RestTimeCalc.new(retirement_asset_calc, user.id, asset_config)
  end
end
