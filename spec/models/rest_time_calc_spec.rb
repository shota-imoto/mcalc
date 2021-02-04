require 'rails_helper'

RSpec.describe RestTimeCalc, type: :model do
  describe 'year_calc' do
    let(:user) { create(:user) }
    let(:retirement_asset_calc) { create(:retirement_asset_calc, user: user) }
    let(:asset_config) { create(:asset_config, user: user) }
    let(:asset_formation_calc) { AssetFormationCalc.new(asset_config) }
    let(:rest_time_calc) { RestTimeCalc.new(asset_formation_calc, retirement_asset_calc, user.id) }
    let(:result) { rest_time_calc.asset_years }

    context '必要な設定値が与えられている場合' do
      context '計算結果の年数が経過したときの総資産額を検算した場合' do
        let(:check_calc) { AssetFormationCalc.new(asset_config) }
        subject { check_calc.calculate(result) }

        it '引退目標の資産額を上回っている' do
          is_expected.to be >= retirement_asset_calc.retirement_asset
        end
      end

      context '計算結果の年数の1年前の総資産額を検算した場合' do
        let(:check_calc) { AssetFormationCalc.new(asset_config) }
        subject { check_calc.calculate(result - 1) }

        it '引退目標の資産額を下回っている' do
          is_expected.to be <= retirement_asset_calc.retirement_asset
        end
      end
    end
  end
end
