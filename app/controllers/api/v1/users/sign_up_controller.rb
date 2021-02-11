class Api::V1::Users::SignUpController < ApplicationController
  protect_from_forgery :except => [:create]

  def create
    user = User.new(sign_up_params)
    if user.save
      registration_response = Response.new(status: 'success', message: 'mail for confirmation has sent', user_id: user.id)
    else
      registration_response = Response.new(status: 'error', message: user.errors.messages)
    end
    serializer = ResponseSerializer.new(registration_response)
    render json: serializer.serializable_hash.to_json
  end

  protected

  def sign_up_params
    params.require(:user).permit(:nickname, :email, :password, :password_confirmation)
  end
end
