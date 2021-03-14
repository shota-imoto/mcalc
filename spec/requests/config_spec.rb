require 'rails_helper'

RSpec.describe "Config", :type => :request do
  describe 'create' do
    require 'json'
    include_context :user_with_rest_time_calc_config
    include_context :authenticated_header_by_user
    let(:attributes) { JSON.parse(response.body).dig("data", "attributes") }
    let(:asset_config_attributes) { asset_config.attributes }

    before { post api_v1_config_index_path, headers: headers, params: { asset_config: asset_config_attributes } }

    context "正常系" do
      it "レスポンスオブジェクトはstatus, messagesの2項目を返す" do
        expect(attributes.keys).to eq ["status", "message"]
      end
      it '正常時のメッセージが返される' do
        expect(attributes["message"]).to eq "set configure as #{user.nickname}"
      end
    end

    context '異常系' do
      context 'バリデーションエラーが発生した場合' do
        let(:asset_config_attributes) { asset_config.attributes.merge(monthly_living_cost: nil) }
        it 'エラーメッセージが返される' do
          expect(attributes["message"]).to eq ["現在の資産を入力してください", "現在の資産は数字を入力してください"]
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
