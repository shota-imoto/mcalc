class Api::V1::RetirementAssetConfigController < ApplicationController
  before_action :authenticate

  def create
    if @user
      asset_config = RetirementAssetCalc.find_by_user_or_initialize(retirement_asset_calc_params)
      if asset_config.save
        config_response = RetirementAssetConfigResponse.new(status: 'success', message: "set configure as #{@user.nickname}", user_id: @user.id)
      else
        messages = asset_config.errors.messages
        config_response = RetirementAssetConfigResponse.new(status: 'error', message: messages, user_id: @user.id)
      end
      serializer = RetirementAssetConfigResponseSerializer.new(config_response)
      render json: serializer.serializable_hash.to_json
    else
      message = '認証情報がありません'
      config_response = RetirementAssetConfigResponse.new(status: 'error', message: message)
      serializer = RetirementAssetConfigResponseSerializer.new(config_response)
      render json: serializer.serializable_hash.to_json
    end
  end

  private

  def retirement_asset_calc_params
    params.require(:retirement_asset_calc).permit(:monthly_living_cost, :tax_rate, :annual_yield).merge(user: @user)
  end
end
