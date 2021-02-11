require 'rails_helper'

RSpec.describe "RetirementAssetConfig", :type => :request do
  describe 'create' do
    include_context :user_with_rest_time_calc_config
    include_context :authenticated_header_by_user
    require 'json'

    before { post api_v1_retirement_asset_config_index_path, headers: headers, params: { retirement_asset_calc: retirement_asset_calc.attributes } }

    context "正常系" do
      let(:attributes) { JSON.parse(response.body).dig("data", "attributes") }

      it "レスポンスオブジェクトはstatus, messagesの3項目を返す" do
        expect(attributes.keys).to eq ["status", "message"]
      end
    end
  end
end
