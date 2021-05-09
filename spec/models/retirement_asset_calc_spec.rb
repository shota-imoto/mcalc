require 'rails_helper'

RSpec.describe RetirementAssetCalc, type: :model do
  describe 'calculate!' do
    include_context :user_with_rest_time_calc_config
    subject { (retirement_asset_calc.retirement_asset * retirement_asset_calc.ajust_4per_rule.to_r / 100 / 12).to_i }

    context '必要な設定値が与えられている場合' do
      it '正しい値が算出される' do
        is_expected.to eq(retirement_asset_calc.monthly_living_budget.to_i)
      end
    end
  end
end
