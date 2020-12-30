class RootController < ApplicationController
  def index
    @user = User.new unless user_signed_in?
    @asset_config = AssetConfig.last
    @retirement_asset_calc = RetirementAssetCalc.last
    @yield_config = YieldConfig.last
  end
end
