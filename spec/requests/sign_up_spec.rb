require 'rails_helper'

RSpec.describe "SingUp", :type => :request do
  describe 'create' do
    let(:user) { build(:user) }
    require 'json'

    before { post api_v1_users_sign_up_index_path, params: { user: user.attributes } }

    context "正常系" do
      let(:attributes) { JSON.parse(response.body).dig("data", "attributes") }

      it "レスポンスオブジェクトはstatus, messagesの3項目を返す" do
        expect(attributes.keys).to eq ["status", "message"]
      end
    end
  end
end
