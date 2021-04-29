class Api::V1::RootController < ApplicationController
  before_action :authenticate

  def index
    if @user
      @rest_time_calc = RestTimeCalcBuilder.new(@user).rest_time_calc
      serializer = RestTimeCalcSerializer.new(@rest_time_calc)
    else
      config_response = Response.new(status: 'error', message: '不正なアクセス')
    end
    render json: serializer.serializable_hash.to_json
  end
end
