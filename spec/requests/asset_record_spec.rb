require 'rails_helper'

RSpec.describe "AssetRecord", :type => :request do
  describe 'create' do
    require 'json'
    include_context :authenticated_header_by_user
    let(:user) { create(:user) }
    let(:attributes) { JSON.parse(response.body).dig("data", "attributes") }
    let(:asset_record_attributes) { attributes_for(:asset_record) }
#JWTクラスに持っくる
    before do
      Api::V1::AssetRecordController.new.instance_variable_set(:@user, user)
      post api_v1_asset_record_index_path, headers: headers, params: { asset_record: asset_record_attributes }
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
        let(:asset_record_attributes) { attributes_for(:asset_record).merge(amount: nil) }
        it 'エラーメッセージが返される' do
          expect(attributes["message"]).to eq ["Amount can't be blank", "Amount is not a number"]
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
