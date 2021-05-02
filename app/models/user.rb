class User < ApplicationRecord
  has_one :asset_config
  has_one :yield_config
  has_one :retirement_asset_calc
  has_many :asset_records

  def self.current_asset_record
    asset_records.last
  end
end
