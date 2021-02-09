require 'rails_helper'

RSpec.describe RestTimeCalc, type: :model do
  let(:rest_time_calc) { RestTimeCalc.new(retirement_asset_calc, user.id, asset_config) }
  include_context :user_with_rest_time_calc_config

  describe 'year_calc' do
    let(:result) { rest_time_calc.asset_years }
    let(:check_calc) { AssetFormationCalc.new(asset_config) }

    context '計算結果の年数が経過したときの総資産額を検算した場合' do
      subject { check_calc.calculate(result) }

      it '引退目標の資産額を下回っている' do
        is_expected.to be <= retirement_asset_calc.retirement_asset
      end
    end

    context '計算結果の年数の1年後の総資産額を検算した場合' do
      subject { check_calc.calculate(result + 1) }

      it '引退目標の資産額を上回っている' do
        is_expected.to be >= retirement_asset_calc.retirement_asset
      end
    end
  end

  describe 'month_calc' do
    let(:asset_years) { rest_time_calc.asset_years }
    let(:result) { rest_time_calc.asset_months }
    let(:check_calc) { AssetFormationCalc.new(asset_config) }
    subject { check_calc.calculate(asset_years, asset_months) }

    context '計算結果の年数と月数が経過したときの総資産額を検算した場合' do
      subject { check_calc.calculate(asset_years, result) }

      it '引退目標の資産額を上回っている' do
        is_expected.to be >= retirement_asset_calc.retirement_asset
      end
    end

    context '計算結果の年数と月数の1月前の総資産額を検算した場合' do
      subject { check_calc.calculate(asset_years, result - 1) }

      it '引退目標の資産額を下回っている' do
        is_expected.to be <= retirement_asset_calc.retirement_asset
      end
    end
  end

  describe 'validation' do
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
