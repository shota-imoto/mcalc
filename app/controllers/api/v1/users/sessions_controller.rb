class Api::V1::Users::SessionsController < Devise::SessionsController
  protect_from_forgery :except => [:create, :failed]

  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)

    binding.pry

    session_response = SessionResponse.new(status: 'success', message: "signed in as #{resource.nickname}", user_id: resource.id)
    serializer = SessionResponseSerializer.new(session_response)
    render json: serializer.serializable_hash.to_json
  end

  def failed
    binding.pry
    session_response = SessionResponse.new(status: 'error', message: flash[:alert])
    serializer = SessionResponseSerializer.new(session_response)
    render json: serializer.serializable_hash.to_json
  end

  protected

  def auth_options
    # 失敗時に recall に設定したパスのアクションが呼び出されるので変更
    # { scope: resource_name, recall: "#{controller_path}#new" } # デフォルト
    { scope: :user, recall: "#{controller_path}#failed" }
  end
end


# class Warden::Proxy
#   include MethodSearch

# #   def authenticate!
# #     binding.pry
# #     resource  = password.present? && mapping.to.find_for_database_authentication(authentication_hash)
# #     hashed = false

# #     if validate(resource){ hashed = true; resource.valid_password?(password) }
# #       remember_me(resource)
# #       resource.after_database_authentication
# #       success!(resource)
# #     end

# #     # In paranoid mode, hash the password even when a resource doesn't exist for the given authentication key.
# #     # This is necessary to prevent enumeration attacks - e.g. the request is faster when a resource doesn't
# #     # exist in the database if the password hashing algorithm is not called.
# #     mapping.to.new.password = password if !hashed && Devise.paranoid
# #     unless resource
# #       Devise.paranoid ? fail(:invalid) : fail(:not_found_in_database)
# #     end
# #   end
# end

# module MethodSearch
#   def method_search(method_name)
#     name = method_name.to_sym
#     ancestors = self.class.ancestors
#     ancestors.each do |ancestor|
#       instance_method_list = ancestor.instance_methods(false)
#       return ancestor if instance_method_list.include?(name)
#     end
#     nil
#   end
# end
