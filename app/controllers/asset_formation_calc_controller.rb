class AssetFormationCalcController < ApplicationController
  def index
  end

  def calculate
    @asset_formation_calc = AssetFormationCalc.new(asset_formation_calc_params)
    @asset_formation_calc.calculate
  end

  private

  def asset_formation_calc_params
    params.permit(:monthly_purchase, :annual_yield, :year_later)
  end
end
