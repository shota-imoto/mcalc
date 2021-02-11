class User < ApplicationRecord
  has_secure_password

  validates :nickname, :email, :password, :password_confirmation, presence: true
  validates :nickname, :email, uniqueness: true
  validates :email, format: { with: /[\w|\.]+@\w+\.[\w|\.]+/, message: "メールアドレスではありません" } # @を含む、ドメインには1文字以上"."が含まれる
  validates :password, length: { in: 8..128 }, format: { with: /(?=.*?[a-z])(?=.*?[A-Z])(?=.*?\d).*/, message: "パスワードは数字、半角小文字、半角大文字を1文字ずつ以上含む必要があります" }

  has_one :asset_config
  has_one :yield_config
  has_one :retirement_asset_calc
end
