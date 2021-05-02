require 'rails_helper'

RSpec.describe "Root", :type => :request do
  describe 'index' do
    include_context :user_with_rest_time_calc_config
    include_context :authenticated_header_by_user
    require 'json'

    before { get api_v1_root_path, headers: headers }

    context "正常系" do
      let(:attributes) { JSON.parse(response.body).dig("data", "attributes") }
      let(:messages) { attributes.delete("messages") }

      it "RestTimeCalcクラスのオブジェクトがシリアライズされて返される" do
        expect(JSON.parse(response.body).dig("data", "type")).to eq "rest_time_calc"
      end

      it "RestTimeCalcオブジェクトはasset_years, asset_months, messagesの3項目を返す" do
        expect(attributes.keys).to eq ["asset_years", "asset_months", "messages"]
      end

      it 'レスポンスにエラーメッセージが含まれていない' do
        expect(messages.present?).to be_falsey
      end
    end

    context '未設定の値が存在する場合' do
      let(:asset_config) { nil }
      let(:messages) { JSON.parse(response.body).dig("data", "attributes").delete("messages") }

      context 'メイン設定値が与えられていない場合' do
        it 'レスポンスにエラーメッセージが含まれている' do
          expect(messages.present?).to be_truthy
        end
      end

      context 'リタイア額設定値が与えられていない場合' do
        let(:retirement_asset_calc) { nil }

        it 'レスポンスにエラーメッセージが含まれている' do
          expect(messages.present?).to be_truthy
        end
      end
    end
  end
end
