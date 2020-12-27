class RestTimeCalc
  attr_accessor :asset_formation, :reset_years, :reset_month, :retirement_asset

  def initialize(asset_formation, retirement_asset)
    @asset_formation = asset_formation
    @retirement_asset = retirement_asset
  end

  def year_calc
    while asset_formation.asset_after_one_year < retirement_asset; end
  end
end
