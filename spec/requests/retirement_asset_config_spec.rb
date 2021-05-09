require 'rails_helper'

RSpec.describe "RetirementAssetConfig", :type => :request do
  describe 'create' do
    require 'json'
    include_context :user_with_rest_time_calc_config
    include_context :authenticated_header_by_user
    let(:attributes) { JSON.parse(response.body).dig("data", "attributes") }
    let(:retirement_asset_config_attributes) { retirement_asset_calc.attributes }

    before { post api_v1_retirement_asset_config_index_path, headers: headers, params: { retirement_asset_calc: retirement_asset_config_attributes } }

    context "正常系" do

      it "レスポンスオブジェクトはstatus, messagesの3項目を返す" do
        expect(attributes.keys).to eq ["status", "message"]
      end

      it '正常時のメッセージが返される' do
        expect(attributes["message"]).to eq "set configure"
      end
    end

    context '異常系' do
      context 'バリデーションエラーが発生した場合' do
        let(:retirement_asset_config_attributes) { retirement_asset_calc.attributes.merge(monthly_living_budget: nil) }
        it 'エラーメッセージが返される' do
          expect(attributes["message"]).to eq ["Monthly living budget can't be blank", "Monthly living budget is not a number"]
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
