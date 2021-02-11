require 'rails_helper'

RSpec.describe "Config", :type => :request do
  describe 'create' do
    include_context :user_with_rest_time_calc_config
    include_context :authenticated_header_by_user
    require 'json'

    before { post api_v1_config_index_path, headers: headers, params: { asset_config: asset_config.attributes } }

    context "正常系" do
      let(:attributes) { JSON.parse(response.body).dig("data", "attributes") }

      it "レスポンスオブジェクトはstatus, messagesの3項目を返す" do
        expect(attributes.keys).to eq ["status", "message"]
      end
    end
  end
end
