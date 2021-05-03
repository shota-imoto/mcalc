class RestTimeCalc
  include ActiveModel::Validations

  attr_accessor :asset_config, :retirement_asset, :asset_record, :user_id, :asset_years, :asset_months
  validates :asset_config, :retirement_asset, presence: true

  def initialize(retirement_asset_calc = nil, user_id = nil, asset_config = nil, asset_record = nil)
    @user_id, @asset_config, @retirement_asset, @asset_record = user_id, asset_config, retirement_asset_calc, asset_record
    @asset_years, @asset_months = 0, 0
    calculate! if valid?
  end

  def asset_formation
    @asset_formation ||= AssetFormationCalc.new(asset_config, asset_record)
  end

  def calculate!
    self.asset_years, self.asset_months = to_years_and_months(rest_months_from_last_record)
  end

  def rest_months_from_last_record
    RestMonthCalc.new(retirement_asset, asset_config, asset_record).asset_months
  end

  def rest_days(rest_months)
    rest_months * 30 - passed_days
  end

  def passed_days
    passed_unix_time / 60 / 60 / 24
  end

  def passed_unix_time
    (Time.zone.now - asset_record.date).to_i 
  end

  # 登録日+残月数-現在
  # 残月数-(現在-登録日)

  def to_ymd(days)
    [days / 30 / 12, days / 30 % 12, days % 30]
  end

  def to_years_and_months(months)
    [months / 12, months % 12]
  end

  def user
    @user ||= User.find(user_id)
  end
end
