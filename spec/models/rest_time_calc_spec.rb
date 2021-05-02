require 'rails_helper'

RSpec.describe RestTimeCalc, type: :model do
  let(:rest_time_calc) { RestTimeCalc.new(retirement_asset_calc, user.id, asset_config, asset_record) }
  include_context :user_with_rest_time_calc_config

  describe 'calculate' do
    let(:result_years) { rest_time_calc.asset_years }
    let(:relust_month) { rest_time_calc.asset_months }
    let(:check_calc) { AssetFormationCalc.new(asset_config, asset_record) }

    context '計算結果の年数と月数が経過したときの総資産額を検算した場合' do
      subject { check_calc.calculate!(result_years, relust_month) }

      it '引退目標の資産額を上回っている' do
        is_expected.to be >= retirement_asset_calc.retirement_asset
      end
    end

    context '計算結果の年数と月数の1月前の総資産額を検算した場合' do
      subject { check_calc.calculate!(result_years, relust_month - 1) }

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
