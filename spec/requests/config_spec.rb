require 'rails_helper'

RSpec.describe "Config", :type => :request do
  describe 'create' do
    require 'json'
    include_context :user_with_rest_time_calc_config
    include_context :authenticated_header_by_user
    let(:attributes) { JSON.parse(response.body).dig("data", "attributes") }
    let(:asset_config_attributes) { asset_config.attributes }
#JWTクラスに持っくる
    before do
      Api::V1::ConfigController.new.instance_variable_set(:@user, user)
      post api_v1_config_index_path, headers: headers, params: { asset_config: asset_config_attributes }
    end
    context "正常系" do
      it "レスポンスオブジェクトはstatus, messagesの2項目を返す" do
        expect(attributes.keys).to eq ["status", "message"]
      end
      it '正常時のメッセージが返される' do
        expect(attributes["message"]).to eq "set configure"
      end
    end

    context '異常系' do
      context 'バリデーションエラーが発生した場合' do
        let(:asset_config_attributes) { asset_config.attributes.merge(initial_asset: nil) }
        it 'エラーメッセージが返される' do
          expect(attributes["message"]).to eq ["Initial asset can't be blank", "Initial asset is not a number"]
        end
      end

      context '認証トークンがない場合' do
        let(:headers) { { Authorization: nil } }
        it 'エラーメッセージが返される' do
          expect(attributes["message"]).to eq "不正なアクセス"
        end
      end
    end
  end
end
