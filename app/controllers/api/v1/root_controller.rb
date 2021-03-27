class Api::V1::RootController < ApplicationController
  before_action :authenticate

  def index
    if @user
      builder = RestTimeCalcBuilder.new(@user)
      @rest_time_calc = builder.rest_time_calc
      serializer = RestTimeCalcSerializer.new(@rest_time_calc)
      render json: serializer.serializable_hash.to_json
    end
  end
end
