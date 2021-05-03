class RestTimeCalcBuilder
  attr_accessor :rest_time_calc

  def initialize(user)
    asset_config = user.asset_config
    retirement_asset_calc = user.retirement_asset_calc
    asset_record = AssetRecord.latest_users_asset(user)
    @rest_time_calc = RestTimeCalc.new(retirement_asset_calc, user.id, asset_config, asset_record)
  end
end
