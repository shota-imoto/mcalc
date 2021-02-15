class User < ApplicationRecord
  require 'securerandom'
  has_secure_password validations: false

  validates :nickname, :email, :password, :password_confirmation, presence: true
  validates :nickname, :email, uniqueness: true
  validates :email, format: { with: /[\w|\.]+@\w+\.[\w|\.]+/} # @を含む、ドメインには1文字以上"."が含まれる
  validates :password, length: { in: 8..128 }, format: { with: /(?=.*?[a-z])(?=.*?[A-Z])(?=.*?\d).*/ }, confirmation: true

  has_one :asset_config
  has_one :yield_config
  has_one :retirement_asset_calc
end
