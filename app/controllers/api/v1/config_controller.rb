class Api::V1::ConfigController < ApplicationController
  before_action :authenticate

  def new
    asset_config = AssetConfig.find_or_initialize_by(user_id: @user.id)
    serializer = AssetConfigSerializer.new(asset_config)
    render json: serializer.serializable_hash.to_json
  end

  def create
    if @user
      asset_config = AssetConfig.find_by_user_or_initialize(asset_config_params)
      if asset_config.save
        config_response = Response.new(status: 'success', message: "set configure as #{@user.nickname}", user_id: @user.id)
      else
        config_response = Response.new(status: 'error', message: asset_config.errors.full_messages, user_id: @user.id)
      end
      serializer = ResponseSerializer.new(config_response)
      render json: serializer.serializable_hash.to_json
    else
      message = {'認証エラー': '認証情報がありません'}
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
