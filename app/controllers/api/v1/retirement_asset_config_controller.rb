class Api::V1::RetirementAssetConfigController < ApplicationController
  before_action :authenticate
  before_action :set_retirement_asset_config, only: :create

  def new
    serializer = RetirementAssetCalcSerializer.new(retirement_asset_calc)
    render json: serializer.serializable_hash.to_json
  end

  def create
    serializer = ResponseSerializer.new(config_response)
    render json: serializer.serializable_hash.to_json
  end

  private

  def retirement_asset_calc
    RetirementAssetCalc.find_or_initialize_by(user_id: @user.id)
  end

  def config_response
    if @user.nil?
      Response.new(status: 'error', message: '不正なアクセス')
    elsif @retirement_asset_config.save
      Response.new(status: 'success', message: "set configure", user_id: @user.id)
    else
      Response.new(status: 'error', message: @retirement_asset_config.errors.full_messages, user_id: @user.id)
    end
  end

  def set_retirement_asset_config
    @retirement_asset_config = RetirementAssetCalc.find_by_user_or_initialize(retirement_asset_calc_params)
  end

  def retirement_asset_calc_params
    params.require(:retirement_asset_calc).permit(:monthly_living_budget, :ajust_4per_rule).merge(user: @user)
  end
end
