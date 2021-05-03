class AssetRecord < ApplicationRecord
	belongs_to :user
	validates :amount, presence: true, numericality: true
	validates :date, presence: true
	validates :date, uniqueness: { scope: :user_id }

	scope :latest_users_asset, -> (user) { where(user_id: user.id).order(:date).last }

	def date=(value)
		super AssetRecordDate.new(value).date
	end
end