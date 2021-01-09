class RootController < ApplicationController
  def index
    if user_signed_in?
      # todo: implement as builder pattern again.
      @yield_config = current_user.yield_config
      @asset_config = current_user.asset_config
      @retirement_asset_calc = current_user.retirement_asset_calc
      if @asset_config.present? && @yield_config.present? && @retirement_asset_calc.present?
        @asset_formation_calc = AssetFormationCalc.new(@asset_config, @yield_config)
        @rest_time_calc = RestTimeCalc.new(@asset_formation_calc, @retirement_asset_calc)
      end
    else
      @user = User.new
    end
  end
end
