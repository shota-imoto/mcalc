class ApplicationController < ActionController::Base
  def user_confirmed?
    if user_signed_in?
      redirect_to new_user_confirmation_path if current_user.confirmed?
    end
  end
end
