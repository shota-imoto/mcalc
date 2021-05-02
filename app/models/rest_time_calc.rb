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
    loop.with_index do |_, i|
      if asset_config.asset_after_one_month(asset_formation.asset_sum) > retirement_asset.retirement_asset
        self.asset_years, self.asset_months = to_years_and_months(i + 1)
        break
      end
      asset_formation.asset_sum = asset_config.asset_after_one_month(asset_formation.asset_sum)
    end
  end

  def to_years_and_months(months)
    [months / 12, months % 12]
  end

  def user
    @user ||= User.find(user_id)
  end
end
