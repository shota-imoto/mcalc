# monthly_living_cost: (万円/月)

class RetirementAssetCalc < ApplicationRecord
  belongs_to :user

  def self.find_by_user_or_initialize(params)
    asset_config = find_or_initialize_by(user: params[:user])
    asset_config.assign_attributes(params)
    asset_config
  end

  def retirement_asset
    @retirement_asset ||= calculate
  end

  def calculate
    (annual_living_cost.to_r / yield_including_tax).to_f
  end

  def annual_living_cost
    monthly_living_cost.to_r * 12r
  end

  def yield_including_tax
    annual_yield.to_r * 0.01r * tax_rate.to_r * 0.01r
  end
end
