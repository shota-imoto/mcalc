require 'rails_helper'

shared_context :user_with_rest_time_calc_config do
  let(:user) { create(:user) }
  let!(:retirement_asset_calc) { create(:retirement_asset_calc, user: user) }
  let!(:asset_config) { create(:asset_config, user: user) }
  let!(:asset_record) { create(:asset_record, user: user) }
end
