class RestTimeCalc
  include ActiveModel::Validations

  attr_accessor :asset_config, :retirement_asset, :user_id, :asset_years, :asset_months
  validates :asset_config, :retirement_asset, presence: true

  def initialize(retirement_asset_calc = nil, user_id = nil, asset_config = nil)
    @user_id, @asset_config, @retirement_asset = user_id, asset_config, retirement_asset_calc
    @asset_years, @asset_month = 0, 0
    calculate! if valid?
  end

  def asset_formation
    @asset_formation ||= asset_formation_calc = AssetFormationCalc.new(asset_config)
  end

  def calculate!
    year_calc!
    month_calc!
  end

  def year_calc!
    loop.with_index do |_, i|
      break self.asset_years = i if asset_formation.asset_after_one_year > retirement_asset.retirement_asset
    end
  end

  def month_calc!
    asset_formation.reset!
    asset_formation.asset_after_years(asset_years)
    loop.with_index do |_, i|
      break self.asset_months = i + 1 if asset_formation.asset_after_one_month > retirement_asset.retirement_asset
    end
  end

  def user
    @user ||= User.find(user_id)
  end
end
