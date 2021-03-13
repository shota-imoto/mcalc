class Api::V1::Users::SignInController < ApplicationController

  def create
    user = User.find_or_initialize_by(email: user_params[:email])
    if user.authenticate(user_params[:password])
      response.headers['X-Authentication-Token'] = issue(user.id)
      session_response = Response.new(status: 'success', message: "signed in as #{user.nickname}", user_id: user.id)
    else
      session_response = Response.new(status: 'error', message: user.errors.full_messages)
    end
    serializer = ResponseSerializer.new(session_response)
    render json: serializer.serializable_hash.to_json
  end

  protected

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
