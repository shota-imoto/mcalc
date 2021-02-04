require 'rails_helper'

RSpec.describe RetirementAssetCalc, type: :model do

  describe 'calculate!' do
    let(:user) { create(:user) }
    let(:asset_config) { create(:asset_config, user: user) }
    let!(:retirement_asset_calc) { create(:retirement_asset_calc, user: user) }
    subject { (retirement_asset_calc.retirement_asset * retirement_asset_calc.annual_yield.to_r / 100 * retirement_asset_calc.tax_rate.to_r / 100 / 12).to_i }

    context '必要な設定値が与えられている場合' do
      it '正しい値が算出される' do
        is_expected.to eq(retirement_asset_calc.monthly_living_cost.to_i)
      end
    end
  end
end
