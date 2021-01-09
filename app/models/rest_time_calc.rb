class RestTimeCalc
  attr_accessor :asset_formation, :asset_years, :asset_month, :retirement_asset

  def initialize(asset_formation, retirement_asset_calc)
    @asset_formation = asset_formation
    @retirement_asset = retirement_asset_calc
    @asset_years = 0
    year_calc
  end

  def self.test_case
    new(AssetFormationCalc.test_case, RetirementAssetCalc.test_case)
  end

  def year_calc
    retirement_asset.calculate!
    loop.with_index do |_, i|
      break self.asset_years = i + 1 if asset_formation.asset_after_one_year > retirement_asset.retirement_asset
    end
    self
  end

  def year_calc_test(years)
    asset_formation.asset_after_years(years)
  end
end
