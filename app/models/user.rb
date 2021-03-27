class User < ApplicationRecord
  include UserConfirmationModule
  include UserResetPasswordModule
  require 'securerandom'
  # has_secure_password validations: false

  # validates :nickname, presence: true, uniqueness: true

  has_one :asset_config
  has_one :yield_config
  has_one :retirement_asset_calc

  # alias old_authenticate authenticate

  def authenticate(password)
    return errors.add(:email, :no_record) && false if new_record?
    return errors.add(:password, :wrong_password) && false unless old_authenticate(password)
    self
  end
end
