class AssetRecord < ApplicationRecord
	belongs_to :user
	validates :amount, presence: true, numericality: true
	validates :date, presence: true
	validates :date, uniqueness: { scope: :user_id }

	scope :latest_users_asset, -> (user) { where(user_id: user.id).order(:date).last }

	def self.find_by_month_or_initialize_by(arg)
		date_range = arg[:date].to_date.beginning_of_month..arg[:date].to_date.end_of_month
		record = find_by(arg.merge(date: date_range))
		record || new(arg)
	end
end