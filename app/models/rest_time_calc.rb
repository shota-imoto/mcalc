class RestTimeCalc
  include ActiveModel::Validations

  attr_reader :asset_config, :retirement_asset, :asset_record, :user_id
  validates :asset_config, :retirement_asset, presence: true

  def initialize(retirement_asset_calc = nil, user_id = nil, asset_config = nil, asset_record = nil)
    @user_id, @asset_config, @retirement_asset, @asset_record = user_id, asset_config, retirement_asset_calc, asset_record
  end

  def rest_years
    rest_ymd[0]
  end

  def rest_months
    rest_ymd[1]
  end

  def rest_days
    rest_ymd[2]
  end
  
  def rest_ymd
    return Array.new(3) { nil } if invalid?
    [rest_period_days / 30 / 12, rest_period_days / 30 % 12, rest_period_days % 30]
  end

  def rest_period_days
    rest_months_from_last_record * 30 - passed_days
  end
  
  def rest_months_from_last_record
    @rest_months ||= RestMonthCalc.new(retirement_asset, asset_config, asset_record).rest_months
  end

  def passed_days
    passed_unix_time / 60 / 60 / 24
  end

  def passed_unix_time
    (now - asset_record.date).to_i 
  end

  def now
    @now ||= Time.zone.now
  end

  def user
    @user ||= User.find(user_id)
  end
end
