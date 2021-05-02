class RestTimeCalcBuilder
  attr_accessor :rest_time_calc

  def initialize(user)
    asset_config = user.asset_config
    retirement_asset_calc = user.retirement_asset_calc
    asset_record = user.asset_records.last
    @rest_time_calc = RestTimeCalc.new(retirement_asset_calc, user.id, asset_config, asset_record)
  end
end
