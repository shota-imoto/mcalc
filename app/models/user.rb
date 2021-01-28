class User < ApplicationRecord
  has_secure_token

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable

  validates :nickname, presence: true

  has_one :asset_config
  has_one :yield_config
  has_one :retirement_asset_calc
end
