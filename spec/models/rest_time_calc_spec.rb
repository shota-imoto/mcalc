require 'rails_helper'

RSpec.describe RestTimeCalc, type: :model do
  let(:rest_time_calc) { RestTimeCalc.new(retirement_asset_calc, user.id, asset_config, asset_record) }
  include_context :user_with_rest_time_calc_config

  describe 'retire_day' do
    subject { rest_time_calc.retire_day }

    context '正常系' do
      it { expect { subject }.to_not raise_error }
    end
  end

  describe 'rest_days' do
    subject { rest_time_calc.rest_days }

    context '正常系' do
      it { expect { subject }.to_not raise_error }
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
