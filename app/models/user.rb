class User < ApplicationRecord
  # has_secure_password

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable

  validates :nickname, presence: true

  has_one :asset_config
  has_one :yield_config
  has_one :retirement_asset_calc

  # def password_digest; encrypted_password; end
end
