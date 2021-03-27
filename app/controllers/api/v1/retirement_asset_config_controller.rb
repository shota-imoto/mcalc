class Api::V1::RetirementAssetConfigController < ApplicationController
  before_action :authenticate
  before_action :set_retirement_asset_config, only: :create

  def new
    retirement_asset_calc = RetirementAssetCalc.find_or_initialize_by(user_id: @user.id)
    serializer = RetirementAssetCalcSerializer.new(retirement_asset_calc)
    render json: serializer.serializable_hash.to_json
  end

  def create
    if @user.nil?
      config_response = Response.new(status: 'error', message: '不正なアクセス')
    elsif @retirement_asset_config.save
      config_response = Response.new(status: 'success', message: "set configure", user_id: @user.id)
    else
      config_response = Response.new(status: 'error', message: @retirement_asset_config.errors.full_messages, user_id: @user.id)
    end
    serializer = ResponseSerializer.new(config_response)
    render json: serializer.serializable_hash.to_json
  end

  private

  def set_retirement_asset_config
    @retirement_asset_config = RetirementAssetCalc.find_by_user_or_initialize(retirement_asset_calc_params)
  end

  def retirement_asset_calc_params
    params.require(:retirement_asset_calc).permit(:monthly_living_cost, :tax_rate, :annual_yield).merge(user: @user)
  end
end
