class User < ApplicationRecord
  has_one :asset_config
  has_one :yield_config
  has_one :retirement_asset_calc
end
