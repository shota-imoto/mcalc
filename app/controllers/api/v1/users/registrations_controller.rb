class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
  protect_from_forgery :except => [:create]

  def create
    build_resource(sign_up_params)
    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
    end
    if resource.valid?
      registration_response = RegistrationResponse.new(status: 'success', message: 'mail for confirmation has sent', user_id: resource.id)
    else
      registration_response = RegistrationResponse.new(status: 'error', message: resource.errors.messages)
    end

    serializer = RegistrationResponseSerializer.new(registration_response)
    render json: serializer.serializable_hash.to_json
  end

  protected

  def sign_up_params
    params.require(:user).permit(:nickname, :email, :password, :password_confirmation)
  end
end
