class Api::V1::ConfigController < ApplicationController
  before_action :authenticate

  def create
    if @user
      asset_config = AssetConfig.find_by_user_or_initialize(asset_config_params)
      if asset_config.save
        config_response = ConfigResponse.new(status: 'success', message: "set configure as #{@user.nickname}", user_id: @user.id)
      else
        messages = asset_config.errors.messages
        config_response = ConfigResponse.new(status: 'error', message: messages, user_id: @user.id)
      end
      serializer = ConfigResponseSerializer.new(config_response)
      render json: serializer.serializable_hash.to_json
    else
      message = '認証情報がありません'
      config_response = ConfigResponse.new(status: 'error', message: message)
      serializer = ConfigResponseSerializer.new(config_response)
      render json: serializer.serializable_hash.to_json
    end
  end

  private

  def asset_config_params
    params.require(:asset_config).permit(:initial_asset, :monthly_purchase, :annual_yield).merge(user: @user)
  end
end
