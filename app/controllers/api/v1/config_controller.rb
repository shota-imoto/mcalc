class Api::V1::ConfigController < ApplicationController
  before_action :authenticate
  before_action :set_asset_config, only: :create

  def new
    serializer = AssetConfigSerializer.new(asset_config)
    render json: serializer.serializable_hash.to_json
  end

  def create
    serializer = ResponseSerializer.new(config_response)
    render json: serializer.serializable_hash.to_json
  end

  private

  def asset_config
    AssetConfig.find_or_initialize_by(user_id: @user.id)
  end

  def config_response
    if @user.nil?
      Response.new(status: 'error', message: '不正なアクセス')
    elsif @asset_config.save
      Response.new(status: 'success', message: "set configure", user_id: @user.id)
    else
      Response.new(status: 'error', message: @asset_config.errors.full_messages, user_id: @user.id)
    end
  end

  def set_asset_config
    @asset_config = AssetConfig.find_by_user_or_initialize(asset_config_params)
  end

  def asset_config_params
    params.require(:asset_config).permit(:monthly_purchase, :annual_yield).merge(user: @user)
  end
end
