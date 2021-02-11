class Api::V1::RetirementAssetConfigController < ApplicationController
  before_action :authenticate

  def new
    retirement_asset_calc = RetirementAssetCalc.find_or_initialize_by(user_id: @user.id)
    serializer = RetirementAssetCalcSerializer.new(retirement_asset_calc)
    render json: serializer.serializable_hash.to_json
  end

  def create
    if @user
      asset_config = RetirementAssetCalc.find_by_user_or_initialize(retirement_asset_calc_params)
      if asset_config.save
        config_response = Response.new(status: 'success', message: "set configure as #{@user.nickname}", user_id: @user.id)
      else
        messages = asset_config.errors.messages
        config_response = Response.new(status: 'error', message: messages, user_id: @user.id)
      end
      serializer = ResponseSerializer.new(config_response)
      render json: serializer.serializable_hash.to_json
    else
      message = '認証情報がありません'
      config_response = Response.new(status: 'error', message: message)
      serializer = ResponseSerializer.new(config_response)
      render json: serializer.serializable_hash.to_json
    end
  end

  private

  def retirement_asset_calc_params
    params.require(:retirement_asset_calc).permit(:monthly_living_cost, :tax_rate, :annual_yield).merge(user: @user)
  end
end
