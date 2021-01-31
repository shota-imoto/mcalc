class Api::V1::RootController < ApplicationController
  # before_action :user_confirmed?

  def index
    jwt_token = request.authorization.remove("Token ", "")
    if jwt_token
      payload = decode(jwt_token)
      user = User.find(payload[0]["sub"])
      builder = RestTimeCalcBuilder.new(user)
      @rest_time_calc = builder.rest_time_calc
      serializer = RestTimeCalcSerializer.new(@rest_time_calc, serializer_options)
      render json: serializer.serializable_hash.to_json
    else
      render :json
    end
  end

  private

  def serializer_options
    options = {}
    options[:include] = [:'user.nickname']
    options
  end
end
