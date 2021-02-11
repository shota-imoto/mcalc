require 'rails_helper'

RSpec.describe "SingIn", :type => :request do
  describe 'create' do
    let(:user) { create(:user) }
    require 'json'

    before { post api_v1_users_sign_in_index_path, params: { user: { email: user.email, password: user.password } } }

    context "正常系" do
      let(:attributes) { JSON.parse(response.body).dig("data", "attributes") }

      it "レスポンスオブジェクトはstatus, messagesの3項目を返す" do
        expect(attributes.keys).to eq ["status", "message"]
      end
    end
  end
end
