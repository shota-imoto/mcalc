require 'rails_helper'

RSpec.describe RestTimeCalcBuilder, type: :model do
  describe 'new' do
    include_context :user_with_rest_time_calc_config
    let(:builder) { RestTimeCalcBuilder.new(user) }
    subject { builder.rest_time_calc.rest_days }

    context '必要な設定値が与えられている場合' do
      it '計算結果として数字が返される' do
        is_expected.to be_a(Integer)
      end
    end
  end
end
