class RootController < ApplicationController
  def index
    if user_signed_in?
      builder = RestTimeCalcBuilder.new(current_user)
      @rest_time_calc = builder.rest_time_calc
    else
      @user = User.new
    end
  end
end
