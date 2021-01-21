class Api::V1::RootController < ApplicationController
  # before_action :user_confirmed?

  def index
    sign_in User.last
    if user_signed_in?
      builder = RestTimeCalcBuilder.new(current_user)
      @rest_time_calc = builder.rest_time_calc
      serializer = RestTimeCalcSerializer.new(@rest_time_calc, serializer_options)
      render json: serializer.serializable_hash.to_json
    else
      @user = User.new
    end
  end

  private

  def serializer_options
    options = {}
    options[:include] = [:'user.nickname']
    options
  end
end
