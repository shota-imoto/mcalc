class RestMonthCalc
  include ActiveModel::Validations

  attr_reader :asset_config, :retirement_asset, :asset_record
  validates :asset_config, :retirement_asset, presence: true

  def initialize(retirement_asset_calc = nil, asset_config = nil, asset_record = nil)
    @asset_config, @retirement_asset, @asset_record = asset_config, retirement_asset_calc, asset_record
  end

  def asset_formation
    @asset_formation ||= AssetFormationCalc.new(asset_config, asset_record)
  end

  def rest_months
    return 0 unless asset_config && retirement_asset

    loop.with_index do |_, m|
      break m + 1 if asset_config.asset_after_one_month(asset_formation.asset_sum) > retirement_asset.retirement_asset
      asset_formation.asset_sum = asset_config.asset_after_one_month(asset_formation.asset_sum)
    end
  end
end
