# monthly_living_budget: (万円/月)

class RetirementAssetCalc < ApplicationRecord
  belongs_to :user
  validates :monthly_living_budget, presence: true
  validates :monthly_living_budget, numericality: { greater_than: 0 }
  validates :ajust_4per_rule, numericality: { greater_than: 0, less_than_or_equal_to: 100 }

  def self.find_by_user_or_initialize(params)
    asset_config = find_or_initialize_by(user: params[:user])
    asset_config.assign_attributes(params)
    asset_config
  end

  def retirement_asset
    @retirement_asset ||= calculate
  end

  def calculate
    (annual_living_cost.to_r / (ajust_4per_rule.to_r * 0.01r)).to_f
  end

  def annual_living_cost
    monthly_living_budget.to_r * 12r
  end
end
