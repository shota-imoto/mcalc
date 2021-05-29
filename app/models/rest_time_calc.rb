class RestTimeCalc
  include ActiveModel::Validations

  attr_reader :asset_config, :retirement_asset, :asset_record, :user_id
  validates :asset_config, :retirement_asset, presence: true

  def initialize(retirement_asset_calc = nil, user_id = nil, asset_config = nil, asset_record = nil)
    @user_id, @asset_config, @retirement_asset, @asset_record = user_id, asset_config, retirement_asset_calc, asset_record
  end

  def retire_day
    asset_record.date + rest_months_from_last_record.months
  end

  def rest_days
    (retire_day - Time.zone.today).to_i
  end

  def rest_months_from_last_record
    @rest_months ||= RestMonthCalc.new(retirement_asset, asset_config, asset_record).rest_months
  end

  def user
    @user ||= User.find(user_id)
  end
end
