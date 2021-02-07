require 'rails_helper'

RSpec.describe RestTimeCalc, type: :model do
  describe 'year_calc' do
    include_context :user_with_rest_time_calc_config
    let(:rest_time_calc) { RestTimeCalc.new(retirement_asset_calc, user.id, asset_config) }
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

    context '必要な設定値が与えられていない場合' do
      subject { rest_time_calc.errors.messages.size }
      before { rest_time_calc.valid? }

      context 'メイン設定値が与えられていない場合' do
        let(:asset_config) { nil }
        it 'バリデーションエラーが格納されている' do
          is_expected.to eq 1
        end
      end

      context 'リタイア額設定値が与えられていない場合' do
        let(:retirement_asset_calc) { nil }
        it 'バリデーションエラーが格納されている' do
          is_expected.to eq 1
        end
      end
    end
  end
end
