class RootController < ApplicationController
  def index
    @asset_config = AssetConfig.last
    @retirement_asset_calc = RetirementAssetCalc.last
    @yield_config = YieldConfig.last
  end
end
