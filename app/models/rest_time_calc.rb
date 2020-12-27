class RestTimeCalc
  attr_accessor :asset_sum, :retirement_asset, :rest_time

  def initialize(asset_sum, retirement_asset)
    @asset_sum = asset_sum || 0
    @retirement_asset = retirement_asset
    @rest_time = 0
  end

  def calculate
  end


end
