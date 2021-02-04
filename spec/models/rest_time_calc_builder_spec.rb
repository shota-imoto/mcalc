require 'rails_helper'

RSpec.describe RestTimeCalcBuilder, type: :model do
  describe 'new' do
    let(:user) { create(:user) }
    let!(:retirement_asset_calc) { create(:retirement_asset_calc, user: user) }
    let!(:asset_config) { create(:asset_config, user: user) }
    let(:builder) { RestTimeCalcBuilder.new(user) }
    subject { builder.rest_time_calc.asset_years }

    context '必要な設定値が与えられている場合' do
      it '計算結果として数字が返される' do
        is_expected.to be_a(Integer)
      end
    end
  end
end
