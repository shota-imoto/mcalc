class AssetRecordDate
	attr_reader :date

	def initialize(value)
		@date = Time.zone.parse(value).change(hour: 0).to_formatted_s(:db)
	end
end