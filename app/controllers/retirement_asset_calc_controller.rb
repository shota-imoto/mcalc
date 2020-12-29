class RetirementAssetCalcController < ApplicationController
  def new
    @retirement_asset_calc = RetirementAssetCalc.new
  end

  def create
    @retirement_asset_calc = RetirementAssetCalc.new(retirement_asset_calc_params)
    if @retirement_asset_calc.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @retirement_asset_calc = RetirementAssetCalc.last
  end

  def update
    @retirement_asset_calc = RetirementAssetCalc.last
    if @retirement_asset_calc.update(retirement_asset_calc_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def retirement_asset_calc_params
    params.require(:retirement_asset_calc).permit!
  end
end
