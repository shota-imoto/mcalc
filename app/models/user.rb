class User < ApplicationRecord
  has_secure_password

  validates :nickname, presence: true

  has_one :asset_config
  has_one :yield_config
  has_one :retirement_asset_calc

  def encrypted_password=(encrypted)
    password_digest=(encrypted)
  end
end
