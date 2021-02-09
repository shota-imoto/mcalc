class RestTimeCalc
  include ActiveModel::Validations

  attr_accessor :asset_formation, :asset_years, :asset_months, :retirement_asset, :user_id, :asset_config
  validates :asset_config, :retirement_asset, presence: true

  def initialize(retirement_asset_calc = nil, user_id = nil, asset_config = nil)
    @user_id = user_id
    @asset_config = asset_config
    @retirement_asset = retirement_asset_calc
    @asset_years = 0
    @asset_month = 0
    return if invalid?
    year_calc
    month_calc
  end

  def asset_formation
    @asset_formation ||= asset_formation_calc = AssetFormationCalc.new(asset_config)
  end

  def year_calc
    loop.with_index do |_, i|
      break self.asset_years = i if asset_formation.asset_after_one_year > retirement_asset.retirement_asset
    end
    self
  end

  def month_calc
    asset_formation.reset!
    asset_formation.asset_after_years(asset_years)
    loop.with_index do |_, i|
      break self.asset_months = i + 1 if asset_formation.asset_after_one_month > retirement_asset.retirement_asset
    end
  end

  def user
    User.find(user_id)
  end
end
